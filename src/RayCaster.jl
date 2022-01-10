module RayCaster

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, x_start::T1, y_start::T1, cos_theta::T2, sin_theta::T2) where {T1, T2}
    i_start = floor(Int, x_start) + 1
    j_start = floor(Int, y_start) + 1

    total_euclidean = zero(T1)
    delta_euclidean_per_unit_x = abs(1 / cos_theta)
    delta_euclidean_per_unit_y = abs(1 / sin_theta)

    hit_dimension = 1

    if cos_theta < zero(T2)
        delta_i = -1
        delta_euclidean_x = (x_start - i_start + 1) * delta_euclidean_per_unit_x
    else
        delta_i = 1
        delta_euclidean_x = (i_start - x_start) * delta_euclidean_per_unit_x
    end

    if sin_theta < zero(T2)
        delta_j = -1
        delta_euclidean_y = (y_start - j_start + 1) * delta_euclidean_per_unit_y
    else
        delta_j = 1
        delta_euclidean_y = (j_start - y_start) * delta_euclidean_per_unit_y
    end

    i_stop = i_start
    j_stop = j_start

    while !obstacle_tile_map[i_stop, j_stop]

        if (delta_euclidean_x <= delta_euclidean_y)
            total_euclidean = delta_euclidean_x
            delta_euclidean_x += delta_euclidean_per_unit_x
            i_stop += delta_i
            hit_dimension = 1
        else
            total_euclidean = delta_euclidean_y
            delta_euclidean_y += delta_euclidean_per_unit_y
            j_stop += delta_j
            hit_dimension = 2
        end

    end

    return i_stop, j_stop, hit_dimension, total_euclidean
end

function cast_ray(obstacle_tile_map::AbstractArray{Bool, 2}, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
    I = typeof(i_start_world_units)

    i_start_tile_units = i_start_world_units ÷ world_units_per_tile_unit + one(I)
    j_start_tile_units = j_start_world_units ÷ world_units_per_tile_unit + one(I)

    hypotenuse_squared = delta_i_world_units ^ 2 + delta_j_world_units ^ 2
    hypotenuse = sqrt(hypotenuse_squared)

    abs_delta_i_world_units = abs(delta_i_world_units)
    abs_delta_j_world_units = abs(delta_j_world_units)
    scale = abs_delta_i_world_units * abs_delta_j_world_units

    # delta_euclidean_per_world_unit_i = hypotenuse / abs(delta_i_world_units)
    # delta_euclidean_per_world_unit_j = hypotenuse / abs(delta_j_world_units)

    # delta_euclidean_per_world_unit_i = hypotenuse / abs(delta_i_world_units) * scale
    # delta_euclidean_per_world_unit_j = hypotenuse / abs(delta_j_world_units) * scale

    # delta_euclidean_per_world_unit_i = hypotenuse * abs_delta_j_world_units
    # delta_euclidean_per_world_unit_j = hypotenuse * abs_delta_i_world_units

    delta_euclidean_per_world_unit_i = abs_delta_j_world_units
    delta_euclidean_per_world_unit_j = abs_delta_i_world_units

    # delta_euclidean_per_tile_unit_i = floor(I, world_units_per_tile_unit * delta_euclidean_per_world_unit_i)
    # delta_euclidean_per_tile_unit_j = floor(I, world_units_per_tile_unit * delta_euclidean_per_world_unit_j)

    delta_euclidean_per_tile_unit_i = world_units_per_tile_unit * delta_euclidean_per_world_unit_i
    delta_euclidean_per_tile_unit_j = world_units_per_tile_unit * delta_euclidean_per_world_unit_j

    if delta_i_world_units < zero(I)
        delta_i_tile_units = -one(I)
        delta_euclidean_i = (i_start_world_units - (i_start_tile_units - one(I)) * world_units_per_tile_unit) * delta_euclidean_per_world_unit_i
    else
        delta_i_tile_units = one(I)
        delta_euclidean_i = (i_start_tile_units * world_units_per_tile_unit - i_start_world_units + one(I)) * delta_euclidean_per_world_unit_i
    end

    if delta_j_world_units < zero(I)
        delta_j_tile_units = -one(I)
        delta_euclidean_j = (j_start_world_units - (j_start_tile_units - one(I)) * world_units_per_tile_unit) * delta_euclidean_per_world_unit_j
    else
        delta_j_tile_units = one(I)
        delta_euclidean_j = (j_start_tile_units * world_units_per_tile_unit - j_start_world_units + one(I)) * delta_euclidean_per_world_unit_j
    end

    delta_euclidean_i = floor(I, delta_euclidean_i)
    delta_euclidean_j = floor(I, delta_euclidean_j)

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

    return i_stop_tile_units, j_stop_tile_units, hit_dimension
end

end
