module RayCaster

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
    I = typeof(i_start_world_units)

    i_start_tile_units = i_start_world_units ÷ world_units_per_tile_unit + one(I)
    j_start_tile_units = j_start_world_units ÷ world_units_per_tile_unit + one(I)

    delta_euclidean_per_world_unit_i = abs(delta_j_world_units)
    delta_euclidean_per_world_unit_j = abs(delta_i_world_units)

    delta_euclidean_per_tile_unit_i = world_units_per_tile_unit * delta_euclidean_per_world_unit_i
    delta_euclidean_per_tile_unit_j = world_units_per_tile_unit * delta_euclidean_per_world_unit_j

    if delta_i_world_units < zero(I)
        delta_i_tile_units = -one(I)
        delta_i_world_units_to_exit_start_tile = (i_start_world_units - (i_start_tile_units - one(I)) * world_units_per_tile_unit)
    else
        delta_i_tile_units = one(I)
        delta_i_world_units_to_exit_start_tile = (i_start_tile_units * world_units_per_tile_unit - i_start_world_units + one(I))
    end

    delta_euclidean_i = delta_i_world_units_to_exit_start_tile * delta_euclidean_per_world_unit_i

    if delta_j_world_units < zero(I)
        delta_j_tile_units = -one(I)
        delta_j_world_units_to_exit_start_tile = (j_start_world_units - (j_start_tile_units - one(I)) * world_units_per_tile_unit)
    else
        delta_j_tile_units = one(I)
        delta_j_world_units_to_exit_start_tile = (j_start_tile_units * world_units_per_tile_unit - j_start_world_units + one(I))
    end

    delta_euclidean_j = delta_j_world_units_to_exit_start_tile * delta_euclidean_per_world_unit_j

    i_stop_tile_units = i_start_tile_units
    j_stop_tile_units = j_start_tile_units
    hit_dimension = 1

    while !obstacle_tile_map[i_stop_tile_units, j_stop_tile_units]

        if (delta_euclidean_i <= delta_euclidean_j)
            delta_euclidean_i += delta_euclidean_per_tile_unit_i
            i_stop_tile_units += delta_i_tile_units
            hit_dimension = 1
        else
            delta_euclidean_j += delta_euclidean_per_tile_unit_j
            j_stop_tile_units += delta_j_tile_units
            hit_dimension = 2
        end

    end

    return i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile
end

end
