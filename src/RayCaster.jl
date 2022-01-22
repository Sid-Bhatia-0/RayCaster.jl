module RayCaster

abstract type AbstractDivisionStyle end

struct FloatDivision <: AbstractDivisionStyle end
const FLOAT_DIVISION = FloatDivision()

struct RationalDivision <: AbstractDivisionStyle end
const RATIONAL_DIVISION = RationalDivision()

divide(::FloatDivision, x, y) = x / y
divide(::RationalDivision, x, y) = x // y

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style::AbstractDivisionStyle)
    @assert !(iszero(i_ray_direction) && iszero(j_ray_direction))

    i_ray_start_tile = fld1(x_ray_start, tile_length)
    j_ray_start_tile = fld1(y_ray_start, tile_length)

    return cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps, division_style)
end

get_tile_start(i, tile_length) = (i - one(i)) * tile_length + one(tile_length)
get_tile_end(i, tile_length) = i * tile_length + one(tile_length)

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 1}, tile_length, x_ray_start, i_ray_start_tile, i_ray_direction, max_steps)
    @assert !iszero(i_ray_direction)
    @assert !obstacle_tile_map[i_ray_start_tile]

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

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, x_ray_start, y_ray_start, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps, division_style::AbstractDivisionStyle)
    iszero_i_ray_direction = iszero(i_ray_direction)
    iszero_j_ray_direction = iszero(j_ray_direction)

    @assert !(iszero_i_ray_direction && iszero_j_ray_direction)
    @assert !obstacle_tile_map[i_ray_start_tile, j_ray_start_tile]
    @assert !(x_ray_start == get_tile_start(firstindex(obstacle_tile_map, 1), tile_length))
    @assert !(y_ray_start == get_tile_start(firstindex(obstacle_tile_map, 2), tile_length))
    @assert !(x_ray_start == get_tile_end(lastindex(obstacle_tile_map, 1), tile_length))
    @assert !(y_ray_start == get_tile_end(lastindex(obstacle_tile_map, 2), tile_length))

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

        i_ray_stop = divide(division_style, i_ray_stop, one(i_ray_stop))
        j_ray_stop = divide(division_style, j_ray_stop, one(j_ray_stop))

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

        i_ray_stop = divide(division_style, i_ray_stop, one(i_ray_stop))
        j_ray_stop = divide(division_style, j_ray_stop, one(j_ray_stop))

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
        width_ray_triangle = divide(division_style, height_ray_triangle * abs_j_ray_direction, abs_i_ray_direction)
    else
        width_ray_triangle = cells_travelled_along_j_axis_to_exit_ray_start_tile + (j_steps_taken - one(I)) * tile_length
        height_ray_triangle = divide(division_style, width_ray_triangle * abs_i_ray_direction, abs_j_ray_direction)
    end

    i_ray_stop = x_ray_start + sign_i_ray_direction * height_ray_triangle
    j_ray_stop = y_ray_start + sign_j_ray_direction * width_ray_triangle

    return i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
end

end
