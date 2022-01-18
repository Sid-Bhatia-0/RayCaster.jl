module RayCaster

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, i_ray_start, j_ray_start, i_ray_direction, j_ray_direction, max_steps)
    @assert !(iszero(i_ray_direction) && iszero(j_ray_direction))

    i_ray_start_tile = fld1(i_ray_start, tile_length)
    j_ray_start_tile = fld1(j_ray_start, tile_length)

    return cast_ray(obstacle_tile_map, tile_length, i_ray_start, j_ray_start, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps)
end

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, i_ray_start, j_ray_start, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps)
    @assert !(iszero(i_ray_direction) && iszero(j_ray_direction))

    I = typeof(i_ray_start)

    if i_ray_direction < zero(I)
        i_tile_step_size = -one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start - (i_ray_start_tile - one(I)) * tile_length - one(I))
        sign_i_ray_direction = -one(I)
        abs_i_ray_direction = -i_ray_direction
    elseif i_ray_direction > zero(I)
        i_tile_step_size = one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_tile * tile_length + one(I)- i_ray_start)
        sign_i_ray_direction = one(I)
        abs_i_ray_direction = i_ray_direction
    else
        i_tile_step_size = zero(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_tile * tile_length + one(I) - i_ray_start)
        sign_i_ray_direction = i_ray_direction
        abs_i_ray_direction = i_ray_direction
    end

    if j_ray_direction < zero(I)
        j_tile_step_size = -one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start - (j_ray_start_tile - one(I)) * tile_length - one(I))
        sign_j_ray_direction = -one(I)
        abs_j_ray_direction = -j_ray_direction
    elseif j_ray_direction > zero(I)
        j_tile_step_size = one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_tile * tile_length + one(I)- j_ray_start)
        sign_j_ray_direction = one(I)
        abs_j_ray_direction = j_ray_direction
    else
        j_tile_step_size = zero(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_tile * tile_length + one(I)- j_ray_start)
        sign_j_ray_direction = j_ray_direction
        abs_j_ray_direction = j_ray_direction
    end

    height_ray_direction_triangle = abs_i_ray_direction + one(I)
    width_ray_direction_triangle = abs_j_ray_direction + one(I)
    scaled_increase_in_ray_length_per_tile_travelled_along_i_axis = tile_length * abs_j_ray_direction
    scaled_increase_in_ray_length_per_tile_travelled_along_j_axis = tile_length * abs_i_ray_direction

    scaled_ray_length_when_traveling_along_i_axis = cells_travelled_along_i_axis_to_exit_ray_start_tile * abs_j_ray_direction
    scaled_ray_length_when_traveling_along_j_axis = cells_travelled_along_j_axis_to_exit_ray_start_tile * abs_i_ray_direction

    i_ray_hit_tile = i_ray_start_tile
    j_ray_hit_tile = j_ray_start_tile
    hit_dimension = 0
    i_steps_taken = zero(I)
    j_steps_taken = zero(I)

    while !obstacle_tile_map[i_ray_hit_tile, j_ray_hit_tile] && i_steps_taken < max_steps && j_steps_taken < max_steps
        if (scaled_ray_length_when_traveling_along_i_axis <= scaled_ray_length_when_traveling_along_j_axis)
            scaled_ray_length_when_traveling_along_i_axis += scaled_increase_in_ray_length_per_tile_travelled_along_i_axis
            i_ray_hit_tile += i_tile_step_size
            hit_dimension = 1
            i_steps_taken += one(I)
        else
            scaled_ray_length_when_traveling_along_j_axis += scaled_increase_in_ray_length_per_tile_travelled_along_j_axis
            j_ray_hit_tile += j_tile_step_size
            hit_dimension = 2
            j_steps_taken += one(I)
        end
    end

    if hit_dimension == 1
        height_ray_triangle = cells_travelled_along_i_axis_to_exit_ray_start_tile + (i_steps_taken - one(I)) * tile_length
        width_ray_triangle = (height_ray_triangle * abs_j_ray_direction) // abs_i_ray_direction
        rounded_width_ray_triangle = round(I, width_ray_triangle, RoundDown)
        i_ray_stop = i_ray_start + sign_i_ray_direction * height_ray_triangle
        j_ray_stop_high = j_ray_hit_tile * tile_length
        j_ray_stop_low = j_ray_stop_high - tile_length + one(I)
        j_ray_stop = clamp(j_ray_start + sign_j_ray_direction * rounded_width_ray_triangle, j_ray_stop_low, j_ray_stop_high)
    elseif hit_dimension == 2
        width_ray_triangle = cells_travelled_along_j_axis_to_exit_ray_start_tile + (j_steps_taken - one(I)) * tile_length
        height_ray_triangle = (width_ray_triangle * abs_i_ray_direction) // abs_j_ray_direction
        rounded_height_ray_triangle = round(I, height_ray_triangle, RoundDown)
        j_ray_stop = j_ray_start + sign_j_ray_direction * width_ray_triangle
        i_ray_stop_high = i_ray_hit_tile * tile_length
        i_ray_stop_low = i_ray_stop_high - tile_length + one(I)
        i_ray_stop = clamp(i_ray_start + sign_i_ray_direction * rounded_height_ray_triangle, i_ray_stop_low, i_ray_stop_high)
    else
        i_ray_stop = i_ray_start
        j_ray_stop = j_ray_start
    end

    return i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
end

end
