module RayCaster

cell_coordinate_to_tile_coordinate(i_cell, cells_per_tile_1d) = (i_cell - one(i_cell)) ÷ cells_per_tile_1d + one(i_cell)

cell_to_tile(i_cell, j_cell, cells_per_tile_1d) = (cell_coordinate_to_tile_coordinate(i_cell, cells_per_tile_1d), cell_coordinate_to_tile_coordinate(j_cell, cells_per_tile_1d))

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
    i_ray_start_tile, j_ray_start_tile = cell_to_tile(i_ray_start_cell, j_ray_start_cell, cells_per_tile_1d)

    return cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps)
end

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_start_tile, j_ray_start_tile, i_ray_direction, j_ray_direction, max_steps)
    I = typeof(i_ray_start_cell)

    @assert !(iszero(i_ray_direction) && iszero(j_ray_direction))

    if i_ray_direction < zero(I)
        i_tile_step_size = -one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_cell - (i_ray_start_tile - one(I)) * cells_per_tile_1d)
        sign_i_ray_direction = -one(I)
        abs_i_ray_direction = -i_ray_direction
    elseif i_ray_direction > zero(I)
        i_tile_step_size = one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_tile * cells_per_tile_1d - i_ray_start_cell + one(I))
        sign_i_ray_direction = one(I)
        abs_i_ray_direction = i_ray_direction
    else
        i_tile_step_size = zero(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_tile * cells_per_tile_1d - i_ray_start_cell + one(I))
        sign_i_ray_direction = i_ray_direction
        abs_i_ray_direction = i_ray_direction
    end

    if j_ray_direction < zero(I)
        j_tile_step_size = -one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_cell - (j_ray_start_tile - one(I)) * cells_per_tile_1d)
        sign_j_ray_direction = -one(I)
        abs_j_ray_direction = -j_ray_direction
    elseif j_ray_direction > zero(I)
        j_tile_step_size = one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_tile * cells_per_tile_1d - j_ray_start_cell + one(I))
        sign_j_ray_direction = one(I)
        abs_j_ray_direction = j_ray_direction
    else
        j_tile_step_size = zero(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_tile * cells_per_tile_1d - j_ray_start_cell + one(I))
        sign_j_ray_direction = j_ray_direction
        abs_j_ray_direction = j_ray_direction
    end

    height_ray_direction_triangle = abs_i_ray_direction + one(I)
    width_ray_direction_triangle = abs_j_ray_direction + one(I)
    scaled_increase_in_ray_length_per_tile_travelled_along_i_axis = cells_per_tile_1d * width_ray_direction_triangle
    scaled_increase_in_ray_length_per_tile_travelled_along_j_axis = cells_per_tile_1d * height_ray_direction_triangle

    scaled_ray_length_when_traveling_along_i_axis = cells_travelled_along_i_axis_to_exit_ray_start_tile * width_ray_direction_triangle
    scaled_ray_length_when_traveling_along_j_axis = cells_travelled_along_j_axis_to_exit_ray_start_tile * height_ray_direction_triangle

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
        height_ray_triangle = cells_travelled_along_i_axis_to_exit_ray_start_tile + (i_steps_taken - one(I)) * cells_per_tile_1d
        width_ray_triangle = div(height_ray_triangle * width_ray_direction_triangle, height_ray_direction_triangle, RoundNearest)
        i_ray_stop_cell = i_ray_start_cell + sign_i_ray_direction * (height_ray_triangle - one(I))
        j_ray_stop_cell_high = j_ray_hit_tile * cells_per_tile_1d
        j_ray_stop_cell_low = j_ray_stop_cell_high - cells_per_tile_1d + one(I)
        j_ray_stop_cell = clamp(j_ray_start_cell + sign_j_ray_direction * (width_ray_triangle - one(I)), j_ray_stop_cell_low, j_ray_stop_cell_high)
    elseif hit_dimension == 2
        width_ray_triangle = cells_travelled_along_j_axis_to_exit_ray_start_tile + (j_steps_taken - one(I)) * cells_per_tile_1d
        height_ray_triangle = div(width_ray_triangle * height_ray_direction_triangle, width_ray_direction_triangle, RoundNearest)
        j_ray_stop_cell = j_ray_start_cell + sign_j_ray_direction * (width_ray_triangle - one(I))
        i_ray_stop_cell_high = i_ray_hit_tile * cells_per_tile_1d
        i_ray_stop_cell_low = i_ray_stop_cell_high - cells_per_tile_1d + one(I)
        i_ray_stop_cell = clamp(i_ray_start_cell + sign_i_ray_direction * (height_ray_triangle - one(I)), i_ray_stop_cell_low, i_ray_stop_cell_high)
    else
        height_ray_triangle = one(I)
        width_ray_triangle = one(I)
        i_ray_stop_cell = i_ray_start_cell
        j_ray_stop_cell = j_ray_start_cell
    end

    return i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension
end

end
