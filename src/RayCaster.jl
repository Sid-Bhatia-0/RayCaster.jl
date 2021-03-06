module RayCaster

get_segment_start(i, segment_length) = oftype(segment_length, (i - one(i)) * segment_length + one(segment_length))
get_segment_end(i, segment_length) = oftype(segment_length, i * segment_length + one(segment_length))
get_segment(x, segment_length) = convert(Int, fld1(x, segment_length))

scaled_section_formula(x1, y1, x2, y2, m, n) = (m * x2 + n * x1, m * y2 + n * y1)
rotate_plus_90_degrees(x, y) = (-y, x)

cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps) = cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, get_segment(x_ray_start, tile_length), get_segment(y_ray_start, tile_length))

function cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, i_ray_start_tile, j_ray_start_tile)
    @assert max_steps > zero(max_steps)
    @assert tile_length > zero(tile_length)
    @assert !(iszero(x_ray_direction) && iszero(y_ray_direction))
    @assert !obstacle_tile_map[i_ray_start_tile, j_ray_start_tile]
    @assert !(x_ray_start == get_segment_start(firstindex(obstacle_tile_map, 1), tile_length))
    @assert !(y_ray_start == get_segment_start(firstindex(obstacle_tile_map, 2), tile_length))
    @assert !(x_ray_start == get_segment_end(lastindex(obstacle_tile_map, 1), tile_length))
    @assert !(y_ray_start == get_segment_end(lastindex(obstacle_tile_map, 2), tile_length))

    if x_ray_direction < zero(x_ray_direction)
        i_tile_step_size = -one(i_ray_start_tile)
        distance_traveled_along_x_axis_to_exit_ray_start_tile = x_ray_start - get_segment_start(i_ray_start_tile, tile_length)
        sign_x_ray_direction = -one(x_ray_start)
        abs_x_ray_direction = -x_ray_direction
    else
        i_tile_step_size = one(i_ray_start_tile)
        distance_traveled_along_x_axis_to_exit_ray_start_tile = get_segment_end(i_ray_start_tile, tile_length) - x_ray_start
        sign_x_ray_direction = one(x_ray_start)
        abs_x_ray_direction = x_ray_direction
    end

    if y_ray_direction < zero(y_ray_direction)
        j_tile_step_size = -one(j_ray_start_tile)
        distance_traveled_along_y_axis_to_exit_ray_start_tile = y_ray_start - get_segment_start(j_ray_start_tile, tile_length)
        sign_y_ray_direction = -one(y_ray_start)
        abs_y_ray_direction = -y_ray_direction
    else
        j_tile_step_size = one(j_ray_start_tile)
        distance_traveled_along_y_axis_to_exit_ray_start_tile = get_segment_end(j_ray_start_tile, tile_length) - y_ray_start
        sign_y_ray_direction = one(y_ray_start)
        abs_y_ray_direction = y_ray_direction
    end

    scaled_increase_in_ray_length_per_tile_traveled_along_x_axis = tile_length * abs_y_ray_direction
    scaled_increase_in_ray_length_per_tile_traveled_along_y_axis = tile_length * abs_x_ray_direction

    scaled_ray_length_when_traveling_along_x_axis = distance_traveled_along_x_axis_to_exit_ray_start_tile * abs_y_ray_direction
    scaled_ray_length_when_traveling_along_y_axis = distance_traveled_along_y_axis_to_exit_ray_start_tile * abs_x_ray_direction

    i_ray_hit_tile = i_ray_start_tile
    j_ray_hit_tile = j_ray_start_tile
    hit_dimension = 0
    i_steps_taken = zero(max_steps)
    j_steps_taken = zero(max_steps)

    while !obstacle_tile_map[i_ray_hit_tile, j_ray_hit_tile] && i_steps_taken < max_steps && j_steps_taken < max_steps
        if (scaled_ray_length_when_traveling_along_x_axis <= scaled_ray_length_when_traveling_along_y_axis)
            scaled_ray_length_when_traveling_along_x_axis += scaled_increase_in_ray_length_per_tile_traveled_along_x_axis
            i_ray_hit_tile += i_tile_step_size
            hit_dimension = 1
            i_steps_taken += one(i_steps_taken)
        else
            scaled_ray_length_when_traveling_along_y_axis += scaled_increase_in_ray_length_per_tile_traveled_along_y_axis
            j_ray_hit_tile += j_tile_step_size
            hit_dimension = 2
            j_steps_taken += one(j_steps_taken)
        end
    end

    if hit_dimension == 1
        height_ray_triangle_numerator = oftype(tile_length, distance_traveled_along_x_axis_to_exit_ray_start_tile + (i_steps_taken - one(i_steps_taken)) * tile_length)
        height_ray_triangle_denominator = one(height_ray_triangle_numerator)
        width_ray_triangle_numerator = oftype(tile_length, height_ray_triangle_numerator * abs_y_ray_direction)
        width_ray_triangle_denominator = oftype(tile_length, abs_x_ray_direction)
    else
        width_ray_triangle_numerator = oftype(tile_length, distance_traveled_along_y_axis_to_exit_ray_start_tile + (j_steps_taken - one(j_steps_taken)) * tile_length)
        width_ray_triangle_denominator = one(width_ray_triangle_numerator)
        height_ray_triangle_numerator = oftype(tile_length, width_ray_triangle_numerator * abs_x_ray_direction)
        height_ray_triangle_denominator = oftype(tile_length, abs_y_ray_direction)
    end

    x_ray_stop_numerator = x_ray_start * height_ray_triangle_denominator + sign_x_ray_direction * height_ray_triangle_numerator
    x_ray_stop_denominator = height_ray_triangle_denominator
    y_ray_stop_numerator = y_ray_start * width_ray_triangle_denominator + sign_y_ray_direction * width_ray_triangle_numerator
    y_ray_stop_denominator = width_ray_triangle_denominator

    return x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
end

cast_rays!(outputs, obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_direction, y_direction, semi_field_of_view_ratio, max_steps) = cast_rays!(outputs, obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_direction, y_direction, semi_field_of_view_ratio, max_steps, get_segment(x_ray_start, tile_length), get_segment(y_ray_start, tile_length))

function cast_rays!(outputs, obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_direction, y_direction, semi_field_of_view_ratio, max_steps, i_ray_start_tile, j_ray_start_tile)
    num_rays = length(outputs)

    numerator_semi_field_of_view_ratio = numerator(semi_field_of_view_ratio)
    denominator_semi_field_of_view_ratio = denominator(semi_field_of_view_ratio)

    x_camera_plane_direction, y_camera_plane_direction = rotate_plus_90_degrees(x_direction, y_direction)

    x_mid_ray_direction = denominator_semi_field_of_view_ratio * x_direction
    y_mid_ray_direction = denominator_semi_field_of_view_ratio * y_direction

    x_right_ray_direction = x_mid_ray_direction - numerator_semi_field_of_view_ratio * x_camera_plane_direction
    y_right_ray_direction = y_mid_ray_direction - numerator_semi_field_of_view_ratio * y_camera_plane_direction

    x_left_ray_direction = x_mid_ray_direction + numerator_semi_field_of_view_ratio * x_camera_plane_direction
    y_left_ray_direction = y_mid_ray_direction + numerator_semi_field_of_view_ratio * y_camera_plane_direction

    num_segments = num_rays - one(num_rays)
    k = zero(num_segments)

    for i in eachindex(outputs)
        x_ray_direction, y_ray_direction = scaled_section_formula(x_left_ray_direction, y_left_ray_direction, x_right_ray_direction, y_right_ray_direction, k, num_segments - k)
        outputs[i] = (cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, i_ray_start_tile, j_ray_start_tile)..., x_ray_direction, y_ray_direction)
        k += one(k)
    end

    return nothing
end

end
