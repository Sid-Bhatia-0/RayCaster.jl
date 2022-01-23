module RayCaster

abstract type AbstractDivisionStyle end

struct FloatDivision <: AbstractDivisionStyle end
const FLOAT_DIVISION = FloatDivision()
divide(::FloatDivision, x, y) = x / y

struct RationalDivision <: AbstractDivisionStyle end
const RATIONAL_DIVISION = RationalDivision()
divide(::RationalDivision, x, y) = x // y

get_tile_start(i, tile_length) = (i - one(i)) * tile_length + one(tile_length)
get_tile_end(i, tile_length) = i * tile_length + one(tile_length)

cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style::AbstractDivisionStyle) = cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, fld1(x_ray_start, tile_length), fld1(y_ray_start, tile_length), x_ray_direction, y_ray_direction, max_steps, division_style)

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, tile_length, x_ray_start, y_ray_start, i_ray_start_tile, j_ray_start_tile, x_ray_direction, y_ray_direction, max_steps, division_style::AbstractDivisionStyle)
    @assert !(iszero(x_ray_direction) && iszero(y_ray_direction))
    @assert !obstacle_tile_map[i_ray_start_tile, j_ray_start_tile]
    @assert !(x_ray_start == get_tile_start(firstindex(obstacle_tile_map, 1), tile_length))
    @assert !(y_ray_start == get_tile_start(firstindex(obstacle_tile_map, 2), tile_length))
    @assert !(x_ray_start == get_tile_end(lastindex(obstacle_tile_map, 1), tile_length))
    @assert !(y_ray_start == get_tile_end(lastindex(obstacle_tile_map, 2), tile_length))

    if x_ray_direction < zero(x_ray_direction)
        i_tile_step_size = -one(i_ray_start_tile)
        distance_traveled_along_x_axis_to_exit_ray_start_tile = x_ray_start - get_tile_start(i_ray_start_tile, tile_length)
        sign_x_ray_direction = -one(x_ray_start)
        abs_x_ray_direction = -x_ray_direction
    else
        i_tile_step_size = one(i_ray_start_tile)
        distance_traveled_along_x_axis_to_exit_ray_start_tile = get_tile_end(i_ray_start_tile, tile_length) - x_ray_start
        sign_x_ray_direction = one(x_ray_start)
        abs_x_ray_direction = x_ray_direction
    end

    if y_ray_direction < zero(y_ray_direction)
        j_tile_step_size = -one(j_ray_start_tile)
        distance_traveled_along_y_axis_to_exit_ray_start_tile = y_ray_start - get_tile_start(j_ray_start_tile, tile_length)
        sign_y_ray_direction = -one(y_ray_start)
        abs_y_ray_direction = -y_ray_direction
    else
        j_tile_step_size = one(j_ray_start_tile)
        distance_traveled_along_y_axis_to_exit_ray_start_tile = get_tile_end(j_ray_start_tile, tile_length) - y_ray_start
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
        height_ray_triangle = distance_traveled_along_x_axis_to_exit_ray_start_tile + (i_steps_taken - one(i_steps_taken)) * tile_length
        width_ray_triangle = divide(division_style, height_ray_triangle * abs_y_ray_direction, abs_x_ray_direction)
        height_ray_triangle = oftype(width_ray_triangle, height_ray_triangle)
    else
        width_ray_triangle = distance_traveled_along_y_axis_to_exit_ray_start_tile + (j_steps_taken - one(j_steps_taken)) * tile_length
        height_ray_triangle = divide(division_style, width_ray_triangle * abs_x_ray_direction, abs_y_ray_direction)
        width_ray_triangle = oftype(height_ray_triangle, width_ray_triangle)
    end

    x_ray_stop = x_ray_start + sign_x_ray_direction * height_ray_triangle
    y_ray_stop = y_ray_start + sign_y_ray_direction * width_ray_triangle

    return x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
end

end
