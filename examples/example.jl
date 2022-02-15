import MiniFB as MFB
import RayCaster as RC
import SimpleDraw as SD

mutable struct Game
    tile_map::BitArray{2}
    tile_length::Int
    player_position::CartesianIndex{2}
    num_angles::Int
    player_angle::Int
    player_direction::CartesianIndex{2}
    player_radius::Int
    num_rays::Int
    semi_field_of_view_ratio::Rational{Int}
    max_steps::Int
    ray_cast_outputs::Vector{Tuple{Int, Int, Int, Int, Int, Int, Int, Int, Int}}

    tile_aspect_ratio_camera_view::Rational{Int}

    pu_per_tu::Int
end

function Game(;
        tile_map = BitArray([
                                1 1 1 1 1 1 1 1
                                1 0 0 0 0 0 0 1
                                1 0 0 0 0 0 0 1
                                1 0 0 0 0 0 0 1
                                1 0 0 0 0 0 0 1
                                1 0 0 0 0 0 0 1
                                1 0 0 0 0 0 0 1
                                1 1 1 1 1 1 1 1
                            ]),
        tile_length = 256,
        num_angles = 64,
        player_radius = 32,
        semi_field_of_view_ratio = 2//3,
        num_rays = 512,
        pu_per_tu = 32,
        tile_aspect_ratio_camera_view = 1//1,
        player_position = CartesianIndex((3 * tile_length) ÷ 2, (3 * tile_length) ÷ 2),
        player_angle = 0,
        max_steps = 1024,
    )

    @assert iseven(tile_length)
    @assert tile_length >= 1

    height_tile_map, width_tile_map = size(tile_map)
    @assert height_tile_map >= 4 && width_tile_map >= 4

    @assert all(@view tile_map[:, begin]) && all(@view tile_map[:, end]) && all(@view tile_map[begin, :]) && all(@view tile_map[end, :]) "The tile_map must be closed on all boundaries."

    player_direction = get_player_direction(player_angle, num_angles, player_radius)

    ray_cast_outputs = Array{Tuple{Int, Int, Int, Int, Int, Int, Int, Int, Int}}(undef, num_rays)

    game = Game(
                tile_map,
                tile_length,
                player_position,
                num_angles,
                player_angle,
                player_direction,
                player_radius,
                num_rays,
                semi_field_of_view_ratio,
                max_steps,
                ray_cast_outputs,

                tile_aspect_ratio_camera_view,

                pu_per_tu,
               )

    return game
end

function get_player_direction(player_angle, num_angles, player_radius)
    theta = player_angle * 2 * pi / num_angles
    return CartesianIndex(round(Int, player_radius * cos(theta)), round(Int, player_radius * sin(theta)))
end

is_colliding(tile_map, tile_length, position) = tile_map[RC.get_segment(position[1], tile_length), RC.get_segment(position[2], tile_length)]

function move_forward!(game)
    tile_map = game.tile_map
    tile_length = game.tile_length
    player_position = game.player_position
    player_direction = game.player_direction

    new_player_position = player_position + player_direction

    if !is_colliding(tile_map, tile_length, new_player_position)
        game.player_position = new_player_position
    end

    return nothing
end

function move_backward!(game)
    tile_map = game.tile_map
    tile_length = game.tile_length
    player_position = game.player_position
    player_direction = game.player_direction

    new_player_position = player_position - player_direction

    if !is_colliding(tile_map, tile_length, new_player_position)
        game.player_position = new_player_position
    end

    return nothing
end

function turn_left!(game)
    player_angle = game.player_angle
    num_angles = game.num_angles
    player_radius = game.player_radius

    new_player_angle = mod(player_angle + one(player_angle), num_angles)
    game.player_angle = new_player_angle

    new_player_direction = get_player_direction(new_player_angle, num_angles, player_radius)
    game.player_direction = new_player_direction

    return nothing
end

function turn_right!(game)
    player_angle = game.player_angle
    num_angles = game.num_angles
    player_radius = game.player_radius

    new_player_angle = mod(player_angle - one(player_angle), num_angles)
    game.player_angle = new_player_angle

    new_player_direction = get_player_direction(new_player_angle, num_angles, player_radius)
    game.player_direction = new_player_direction

    return nothing
end

function cast_rays!(game::Game)
    tile_map = game.tile_map
    tile_length = game.tile_length
    player_position = game.player_position
    player_direction = game.player_direction
    ray_cast_outputs = game.ray_cast_outputs
    semi_field_of_view_ratio = game.semi_field_of_view_ratio
    max_steps = game.max_steps

    RC.cast_rays!(ray_cast_outputs, tile_map, tile_length, player_position[1], player_position[2], player_direction[1], player_direction[2], semi_field_of_view_ratio, max_steps)

    return nothing
end

function draw_top_view!(top_view, game, top_view_colors)
    tile_map = game.tile_map
    tile_length = game.tile_length
    pu_per_tu = game.pu_per_tu
    num_rays = game.num_rays
    ray_cast_outputs = game.ray_cast_outputs
    player_position = game.player_position
    
    height_tile_map, width_tile_map = size(tile_map)
    height_top_view, width_top_view = size(top_view)

    # draw tile map
    for j in axes(tile_map, 2)
        for i in axes(tile_map, 1)
            i_top_left = RC.get_segment_start(i, pu_per_tu)
            j_top_left = RC.get_segment_start(j, pu_per_tu)

            tile_shape = SD.FilledRectangle(SD.Point(i_top_left, j_top_left), pu_per_tu, pu_per_tu)

            if tile_map[i, j]
                color = top_view_colors[:wall]
            else
                color = top_view_colors[:empty]
            end

            SD.draw!(top_view, tile_shape, color)

            tile_border_shape = SD.Rectangle(SD.Point(i_top_left, j_top_left), pu_per_tu, pu_per_tu)
            SD.draw!(top_view, tile_border_shape, top_view_colors[:border])
        end
    end

    # draw rays
    wu_per_pu = tile_length ÷ pu_per_tu
    i_player_position_pu = RC.get_segment(player_position[1], wu_per_pu)
    j_player_position_pu = RC.get_segment(player_position[2], wu_per_pu)
    player_position_point = SD.Point(i_player_position_pu, j_player_position_pu)

    for i in 1:num_rays
        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, _ = ray_cast_outputs[i]
        i_ray_stop_pu = RC.get_segment(div(x_ray_stop_numerator, x_ray_stop_denominator, RoundNearest), wu_per_pu)
        j_ray_stop_pu = RC.get_segment(div(y_ray_stop_numerator, y_ray_stop_denominator, RoundNearest), wu_per_pu)
        SD.draw!(top_view, SD.Line(player_position_point, SD.Point(i_ray_stop_pu, j_ray_stop_pu)), top_view_colors[:ray])
    end

    return nothing
end

get_normalized_dot_product(x1, y1, x2, y2) = (x1 * x2 + y1 * y2) / (hypot(x1, y1) * hypot(x2, y2))

function draw_camera_view!(camera_view, game, camera_view_colors)
    tile_map = game.tile_map
    tile_length = game.tile_length
    pu_per_tu = game.pu_per_tu
    player_angle = game.player_angle
    player_position = game.player_position
    player_direction = game.player_direction
    player_radius = game.player_radius
    num_rays = game.num_rays
    ray_cast_outputs = game.ray_cast_outputs
    player_position = game.player_position
    tile_aspect_ratio_camera_view = game.tile_aspect_ratio_camera_view
    semi_field_of_view_ratio = game.semi_field_of_view_ratio
    max_steps = game.max_steps

    height_tile_map, width_tile_map = size(tile_map)
    height_camera_view = size(camera_view, 1)
    i_ray_start_tile = RC.get_segment(player_position[1], tile_length)
    j_ray_start_tile = RC.get_segment(player_position[2], tile_length)

    for i in 1:num_rays
        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension, x_ray_direction, y_ray_direction = ray_cast_outputs[i]

        ray_length = hypot((x_ray_stop_numerator / x_ray_stop_denominator) - player_position[1], (y_ray_stop_numerator / y_ray_stop_denominator) - player_position[2])
        normalized_projected_distance_wu = ray_length * get_normalized_dot_product(player_direction[1], player_direction[2], x_ray_direction, y_ray_direction)

        height_line = tile_aspect_ratio_camera_view * tile_length * num_rays / (2 * semi_field_of_view_ratio * normalized_projected_distance_wu)

        if isfinite(height_line)
            height_line_pu = floor(Int, height_line)
        else
            height_line_pu = height_camera_view
        end

        if tile_map[i_ray_hit_tile, j_ray_hit_tile]
            if hit_dimension == 1
                if i_ray_hit_tile > i_ray_start_tile
                    color = camera_view_colors[:wall1]
                else
                    color = camera_view_colors[:wall3]
                end
            else
                if j_ray_hit_tile > j_ray_start_tile
                    color = camera_view_colors[:wall2]
                else
                    color = camera_view_colors[:wall4]
                end
            end
        else
            color = camera_view_colors[:ceiling]
        end

        if height_line_pu >= height_camera_view - 1
            camera_view[:, i] .= color
        else
            padding_pu = (height_camera_view - height_line_pu) ÷ 2
            camera_view[1:padding_pu, i] .= camera_view_colors[:ceiling]
            camera_view[padding_pu + 1 : end - padding_pu, i] .= color
            camera_view[end - padding_pu + 1 : end, i] .= camera_view_colors[:floor]
        end
    end

    return nothing
end

function copy_image_to_frame_buffer!(frame_buffer, image)
    height_image, width_image = size(image)
    for j in 1:width_image
        for i in 1:height_image
            frame_buffer[j, i] = image[i, j]
        end
    end

    return nothing
end

function draw_debug_view!(debug_view, debug_info)
    font = SD.TERMINUS_32_16
    height_font = 32
    color = 0x00000000

    for (i, line) in enumerate(debug_info)
        SD.draw!(debug_view, SD.TextLine(SD.Point(1 + (i - 1) * height_font, 1), line, font), color)
    end

    return nothing
end

function play!(game::Game)
    color_background = 0x00D0D0D0
    tile_map = game.tile_map
    height_tile_map, width_tile_map = size(tile_map)
    pu_per_tu = game.pu_per_tu

    height_camera_view = 256
    width_camera_view = game.num_rays

    height_top_view = height_tile_map * pu_per_tu
    width_top_view = width_tile_map * pu_per_tu

    max_debug_lines = 4
    max_debug_width = 64
    height_font = 32
    width_font = 16
    height_debug_view = max_debug_lines * height_font
    width_debug_view = max_debug_width * width_font

    height_image = height_top_view + height_camera_view + height_debug_view
    width_image = max(width_top_view, width_camera_view, width_debug_view)

    image = fill(color_background, height_image, width_image)

    camera_view = @view image[begin : height_camera_view, begin : width_camera_view]
    top_view = @view image[height_camera_view + 1 : height_camera_view + height_top_view, begin : width_top_view]
    debug_view = @view image[height_camera_view + height_top_view + 1 : height_camera_view + height_top_view + height_debug_view, begin : width_debug_view]

    camera_view_colors = (wall1 = 0x004063D8, wall2 = 0x00389826, wall3 = 0x009558B2, wall4 = 0x00CB3C33, floor = 0x00000000, ceiling = 0x00FFFFFF)
    top_view_colors = (wall = 0x00FFFFFF, empty = 0x00000000, ray = 0x00808080, border = 0x00cccccc)

    frame_buffer = fill(color_background, width_image, height_image)

    window = MFB.mfb_open(String(nameof(typeof(game))), width_image, height_image)

    steps_taken = 0

    cast_rays!(game)
    draw_camera_view!(camera_view, game, camera_view_colors)
    draw_top_view!(top_view, game, top_view_colors)

    debug_info = String[]
    push!(debug_info, "steps_taken: $(steps_taken)")
    push!(debug_info, "player_position: $(game.player_position)")
    push!(debug_info, "player_direction: $(game.player_direction)")
    draw_debug_view!(debug_view, debug_info)

    copy_image_to_frame_buffer!(frame_buffer, image)

    function keyboard_callback(window, key, mod, is_pressed)::Cvoid
        if is_pressed
            if key == MFB.KB_KEY_Q
                MFB.mfb_close(window)
                return nothing
            elseif key == MFB.KB_KEY_UP
                move_forward!(game)
                steps_taken += 1
            elseif key == MFB.KB_KEY_DOWN
                move_backward!(game)
                steps_taken += 1
            elseif key == MFB.KB_KEY_LEFT
                turn_left!(game)
                steps_taken += 1
            elseif key == MFB.KB_KEY_RIGHT
                turn_right!(game)
                steps_taken += 1
            else
                @warn "No keybinding exists for $(key)"
            end

            fill!(image, color_background)

            cast_rays!(game)
            draw_camera_view!(camera_view, game, camera_view_colors)
            draw_top_view!(top_view, game, top_view_colors)
            empty!(debug_info)
            push!(debug_info, "key: $(key)")
            push!(debug_info, "steps_taken: $(steps_taken)")
            push!(debug_info, "player_position: $(game.player_position)")
            push!(debug_info, "player_direction: $(game.player_direction)")
            draw_debug_view!(debug_view, debug_info)

            copy_image_to_frame_buffer!(frame_buffer, image)
        end

        return nothing
    end

    MFB.mfb_set_keyboard_callback(window, keyboard_callback)

    while MFB.mfb_wait_sync(window)
        state = MFB.mfb_update(window, frame_buffer)

        if state != MFB.STATE_OK
            break;
        end
    end

    return nothing
end

game = Game()

play!(game)
