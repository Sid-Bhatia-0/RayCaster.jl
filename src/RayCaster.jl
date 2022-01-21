module RayCaster

function is_touching_obstacle(obstacle_tile_map::AbstractArray{Bool, 1}, tile_length, x)
    i_tile = fld1(x, tile_length)

    I = typeof(i_tile)

    x_tile_start = get_tile_start(i_tile, tile_length)
    x_tile_end = get_tile_end(i_tile, tile_length)

    i_tile_before = i_tile - one(I)
    i_tile_after = i_tile + one(I)

    is_obstacle_present_1 = checkbounds(Bool, obstacle_tile_map, i_tile_before) && obstacle_tile_map[i_tile_before]
    is_obstacle_present_2 = checkbounds(Bool, obstacle_tile_map, i_tile) && obstacle_tile_map[i_tile]
    is_obstacle_present_3 = checkbounds(Bool, obstacle_tile_map, i_tile_after) && obstacle_tile_map[i_tile_after]

    if x == x_tile_start
        return is_obstacle_present_1 || is_obstacle_present_2
    elseif x == x_tile_end
        return is_obstacle_present_2 || is_obstacle_present_3
    else
        return is_obstacle_present_2
    end
end

function is_touching_obstacle(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, x, y)
    i_tile = fld1(x, tile_length)
    j_tile = fld1(y, tile_length)

    I = typeof(i_tile)

    x_tile_start = get_tile_start(i_tile, tile_length)
    y_tile_start = get_tile_start(j_tile, tile_length)

    x_tile_end = get_tile_end(i_tile, tile_length)
    y_tile_end = get_tile_end(j_tile, tile_length)

    i_tile_before = i_tile - one(I)
    j_tile_before = j_tile - one(I)

    i_tile_after = i_tile + one(I)
    j_tile_after = j_tile + one(I)

    # 1 4 7
    # 2 5 8
    # 3 6 9
    is_obstacle_present_1 = checkbounds(Bool, obstacle_tile_map, i_tile_before, j_tile_before) && obstacle_tile_map[i_tile_before, j_tile_before]
    is_obstacle_present_2 = checkbounds(Bool, obstacle_tile_map, i_tile, j_tile_before) && obstacle_tile_map[i_tile, j_tile_before]
    is_obstacle_present_3 = checkbounds(Bool, obstacle_tile_map, i_tile_after, j_tile_before) && obstacle_tile_map[i_tile_after, j_tile_before]
    is_obstacle_present_4 = checkbounds(Bool, obstacle_tile_map, i_tile_before, j_tile) && obstacle_tile_map[i_tile_before, j_tile]
    is_obstacle_present_5 = checkbounds(Bool, obstacle_tile_map, i_tile, j_tile) && obstacle_tile_map[i_tile, j_tile]
    is_obstacle_present_6 = checkbounds(Bool, obstacle_tile_map, i_tile_after, j_tile) && obstacle_tile_map[i_tile_after, j_tile]
    is_obstacle_present_7 = checkbounds(Bool, obstacle_tile_map, i_tile_before, j_tile_after) && obstacle_tile_map[i_tile_before, j_tile_after]
    is_obstacle_present_8 = checkbounds(Bool, obstacle_tile_map, i_tile, j_tile_after) && obstacle_tile_map[i_tile, j_tile_after]
    is_obstacle_present_9 = checkbounds(Bool, obstacle_tile_map, i_tile_after, j_tile_after) && obstacle_tile_map[i_tile_after, j_tile_after]

    if x == x_tile_start
        if y == y_tile_start
            return is_obstacle_present_1 || is_obstacle_present_2 || is_obstacle_present_4 || is_obstacle_present_5
        elseif y == y_tile_end
            return is_obstacle_present_4 || is_obstacle_present_5 || is_obstacle_present_7 || is_obstacle_present_8
        else
            return is_obstacle_present_4 || is_obstacle_present_5
        end
    elseif x == x_tile_end
        if y == y_tile_start
            return is_obstacle_present_2 || is_obstacle_present_3 || is_obstacle_present_5 || is_obstacle_present_6
        elseif y == y_tile_end
            return is_obstacle_present_5 || is_obstacle_present_6 || is_obstacle_present_8 || is_obstacle_present_9
        else
            return is_obstacle_present_5 || is_obstacle_present_6
        end
    else
        if y == y_tile_start
            return is_obstacle_present_2 || is_obstacle_present_5
        elseif y == y_tile_end
            return is_obstacle_present_5 || is_obstacle_present_8
        else
            return is_obstacle_present_5
        end
    end
end

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps)
    @assert !(iszero(i_ray_direction) && iszero(j_ray_direction))

    i_ray_start_tile = fld1(x_ray_start, tile_length)
    j_ray_start_tile = fld1(y_ray_start, tile_length)

    return cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps)
end

get_tile_start(i, tile_length) = (i - one(i)) * tile_length + one(tile_length)
get_tile_end(i, tile_length) = i * tile_length + one(tile_length)

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 1}, tile_length, x_ray_start, i_ray_start_tile, i_ray_direction, max_steps)
    @assert !iszero(i_ray_direction)
    @assert !is_touching_obstacle(obstacle_tile_map, tile_length, x_ray_start)

    I = typeof(x_ray_start)

    if i_ray_direction < zero(I)
        i_tile_step_size = -one(I)
        distance_to_exit_ray_start_tile = x_ray_start - get_tile_start(i_ray_start_tile, tile_length)
    else
        i_tile_step_size = one(I)
        distance_to_exit_ray_start_tile = get_tile_end(i_ray_start_tile, tile_length) - x_ray_start
    end

    i_ray_hit_tile = i_ray_start_tile
    i_steps_taken = zero(I)

    while !obstacle_tile_map[i_ray_hit_tile] && i_steps_taken < max_steps
        i_ray_hit_tile += i_tile_step_size
        i_steps_taken += one(i_steps_taken)
    end

    total_distance_traveled = distance_to_exit_ray_start_tile + (i_steps_taken - one(I)) * tile_length
    i_ray_stop = x_ray_start + i_tile_step_size * total_distance_traveled

    return i_ray_stop, i_ray_hit_tile
end

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, x_ray_start, y_ray_start, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps)
    iszero_i_ray_direction = iszero(i_ray_direction)
    iszero_j_ray_direction = iszero(j_ray_direction)

    @assert !(iszero_i_ray_direction && iszero_j_ray_direction)
    @assert !is_touching_obstacle(obstacle_tile_map, tile_length, x_ray_start, y_ray_start)
    @assert !(i_ray_start_tile == firstindex(obstacle_tile_map, 1))
    @assert !(j_ray_start_tile == firstindex(obstacle_tile_map, 2))
    @assert !(i_ray_start_tile == lastindex(obstacle_tile_map, 1))
    @assert !(j_ray_start_tile == lastindex(obstacle_tile_map, 2))

    I = typeof(x_ray_start)

    if i_ray_direction < zero(I)
        i_tile_step_size = -one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (x_ray_start - (i_ray_start_tile - one(I)) * tile_length - one(I))
        sign_i_ray_direction = -one(I)
        abs_i_ray_direction = -i_ray_direction
    elseif i_ray_direction > zero(I)
        i_tile_step_size = one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_tile * tile_length + one(I)- x_ray_start)
        sign_i_ray_direction = one(I)
        abs_i_ray_direction = i_ray_direction
    else
        obstacle_tile_map_1d = @view obstacle_tile_map[i_ray_start_tile, :]
        j_ray_stop, j_ray_hit_tile = cast_ray(obstacle_tile_map_1d, tile_length, y_ray_start, j_ray_start_tile, j_ray_direction, max_steps)
        i_ray_stop = x_ray_start
        i_ray_hit_tile = i_ray_start_tile
        hit_dimension = 2
        return i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
    end

    if j_ray_direction < zero(I)
        j_tile_step_size = -one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (y_ray_start - (j_ray_start_tile - one(I)) * tile_length - one(I))
        sign_j_ray_direction = -one(I)
        abs_j_ray_direction = -j_ray_direction
    elseif j_ray_direction > zero(I)
        j_tile_step_size = one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_tile * tile_length + one(I)- y_ray_start)
        sign_j_ray_direction = one(I)
        abs_j_ray_direction = j_ray_direction
    else
        obstacle_tile_map_1d = @view obstacle_tile_map[:, j_ray_start_tile]
        i_ray_stop, i_ray_hit_tile = cast_ray(obstacle_tile_map_1d, tile_length, x_ray_start, i_ray_start_tile, i_ray_direction, max_steps)
        j_ray_stop = y_ray_start
        j_ray_hit_tile = j_ray_start_tile
        hit_dimension = 1
        return i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
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
        i_ray_stop = x_ray_start + sign_i_ray_direction * height_ray_triangle
        j_ray_stop_high = j_ray_hit_tile * tile_length
        j_ray_stop_low = j_ray_stop_high - tile_length + one(I)
        j_ray_stop = clamp(y_ray_start + sign_j_ray_direction * rounded_width_ray_triangle, j_ray_stop_low, j_ray_stop_high)
    else
        width_ray_triangle = cells_travelled_along_j_axis_to_exit_ray_start_tile + (j_steps_taken - one(I)) * tile_length
        height_ray_triangle = (width_ray_triangle * abs_i_ray_direction) // abs_j_ray_direction
        rounded_height_ray_triangle = round(I, height_ray_triangle, RoundDown)
        j_ray_stop = y_ray_start + sign_j_ray_direction * width_ray_triangle
        i_ray_stop_high = i_ray_hit_tile * tile_length
        i_ray_stop_low = i_ray_stop_high - tile_length + one(I)
        i_ray_stop = clamp(x_ray_start + sign_i_ray_direction * rounded_height_ray_triangle, i_ray_stop_low, i_ray_stop_high)
    end

    return i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
end

end
