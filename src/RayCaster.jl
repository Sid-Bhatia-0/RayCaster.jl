module RayCaster

convert_cell_coordinate_to_tile_coordinate(i_cell, cells_per_tile_along_axis) = (i_cell - one(i_cell)) ÷ cells_per_tile_along_axis + one(i_cell)

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, cells_per_tile_along_axis, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
    I = typeof(i_ray_start_cell)

    i_ray_start_tile = convert_cell_coordinate_to_tile_coordinate(i_ray_start_cell, cells_per_tile_along_axis)
    j_ray_start_tile = convert_cell_coordinate_to_tile_coordinate(j_ray_start_cell, cells_per_tile_along_axis)

    scaled_increase_in_ray_length_per_cell_travelled_along_i_axis = abs(j_ray_direction)
    scaled_increase_in_ray_length_per_cell_travelled_along_j_axis = abs(i_ray_direction)

    scaled_increase_in_ray_length_per_tile_travelled_along_i_axis = cells_per_tile_along_axis * scaled_increase_in_ray_length_per_cell_travelled_along_i_axis
    scaled_increase_in_ray_length_per_tile_travelled_along_j_axis = cells_per_tile_along_axis * scaled_increase_in_ray_length_per_cell_travelled_along_j_axis

    if i_ray_direction < zero(I)
        i_tile_step_size = -one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_cell - (i_ray_start_tile - one(I)) * cells_per_tile_along_axis)
    else
        i_tile_step_size = one(I)
        cells_travelled_along_i_axis_to_exit_ray_start_tile = (i_ray_start_tile * cells_per_tile_along_axis - i_ray_start_cell + one(I))
    end

    scaled_ray_length_when_traveling_along_i_axis = cells_travelled_along_i_axis_to_exit_ray_start_tile * scaled_increase_in_ray_length_per_cell_travelled_along_i_axis

    if j_ray_direction < zero(I)
        j_tile_step_size = -one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_cell - (j_ray_start_tile - one(I)) * cells_per_tile_along_axis)
    else
        j_tile_step_size = one(I)
        cells_travelled_along_j_axis_to_exit_ray_start_tile = (j_ray_start_tile * cells_per_tile_along_axis - j_ray_start_cell + one(I))
    end

    scaled_ray_length_when_traveling_along_j_axis = cells_travelled_along_j_axis_to_exit_ray_start_tile * scaled_increase_in_ray_length_per_cell_travelled_along_j_axis

    i_ray_stop_tile = i_ray_start_tile
    j_ray_stop_tile = j_ray_start_tile
    hit_dimension = 0
    i_steps_taken = zero(I)
    j_steps_taken = zero(I)

    while !obstacle_tile_map[i_ray_stop_tile, j_ray_stop_tile] && i_steps_taken < max_steps && j_steps_taken < max_steps
        if (scaled_ray_length_when_traveling_along_i_axis <= scaled_ray_length_when_traveling_along_j_axis)
            scaled_ray_length_when_traveling_along_i_axis += scaled_increase_in_ray_length_per_tile_travelled_along_i_axis
            i_ray_stop_tile += i_tile_step_size
            hit_dimension = 1
            i_steps_taken += one(I)
        else
            scaled_ray_length_when_traveling_along_j_axis += scaled_increase_in_ray_length_per_tile_travelled_along_j_axis
            j_ray_stop_tile += j_tile_step_size
            hit_dimension = 2
            j_steps_taken += one(I)
        end
    end

    if hit_dimension == 1
        signed_perpendicular_distance_to_obstacle = i_tile_step_size * (cells_travelled_along_i_axis_to_exit_ray_start_tile + (i_steps_taken - one(I)) * cells_per_tile_along_axis)
    elseif hit_dimension == 2
        signed_perpendicular_distance_to_obstacle = j_tile_step_size * (cells_travelled_along_j_axis_to_exit_ray_start_tile + (j_steps_taken - one(I)) * cells_per_tile_along_axis)
    else
        signed_perpendicular_distance_to_obstacle = zero(I)
    end

    return i_ray_stop_tile, j_ray_stop_tile, hit_dimension, signed_perpendicular_distance_to_obstacle
end

end
