import RayCaster as RC
import Test

Test.@testset "RayCaster.jl" begin
    obstacle_tile_map = BitArray([
                                  1 1 1 1 1
                                  1 0 0 0 1
                                  1 0 0 0 1
                                  1 0 0 0 1
                                  1 1 1 1 1
                                 ])

    height_obstacle_tile_map = size(obstacle_tile_map, 1)
    width_obstacle_tile_map = size(obstacle_tile_map, 2)

    Test.@testset "Continuous world" begin
        T1 = Float32
        T2 = Float32

        x_start = convert(T1, 5 / 2)
        y_start = convert(T1, 5 / 2)

        Test.@testset "theta = 0" begin
            theta = convert(T2, 0)
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 5
            Test.@test j_stop == 3
            Test.@test hit_dimension == 1
            Test.@test total_euclidean ≈ 1.5
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = atan(2 / 3)" begin
            theta = convert(T2, atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 5
            Test.@test j_stop == 4
            Test.@test hit_dimension == 1
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = (pi / 2) - atan(2 / 3)" begin
            theta = convert(T2, (pi / 2) - atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 4
            Test.@test j_stop == 5
            Test.@test hit_dimension == 2
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = pi / 2" begin
            theta = convert(T2, pi / 2)
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 3
            Test.@test j_stop == 5
            Test.@test hit_dimension == 2
            Test.@test total_euclidean ≈ 1.5
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = (pi / 2) + atan(2 / 3)" begin
            theta = convert(T2, (pi / 2) + atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 2
            Test.@test j_stop == 5
            Test.@test hit_dimension == 2
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = pi - atan(2 / 3)" begin
            theta = convert(T2, pi - atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 1
            Test.@test j_stop == 4
            Test.@test hit_dimension == 1
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = pi" begin
            theta = convert(T2, pi)
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 1
            Test.@test j_stop == 3
            Test.@test hit_dimension == 1
            Test.@test total_euclidean ≈ 1.5
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = pi + atan(2 / 3)" begin
            theta = convert(T2, pi + atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 1
            Test.@test j_stop == 2
            Test.@test hit_dimension == 1
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = (3 * pi / 2) - atan(2 / 3)" begin
            theta = convert(T2, (3 * pi / 2) - atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 2
            Test.@test j_stop == 1
            Test.@test hit_dimension == 2
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = 3 * pi / 2" begin
            theta = convert(T2, 3 * pi / 2)
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 3
            Test.@test j_stop == 1
            Test.@test hit_dimension == 2
            Test.@test total_euclidean ≈ 1.5
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = (3 * pi / 2) + atan(2 / 3)" begin
            theta = convert(T2, (3 * pi / 2) + atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 4
            Test.@test j_stop == 1
            Test.@test hit_dimension == 2
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end

        Test.@testset "theta = 2 * pi - atan(2 / 3)" begin
            theta = convert(T2, 2 * pi - atan(2 / 3))
            cos_theta = cos(theta)
            sin_theta = sin(theta)
            i_stop, j_stop, hit_dimension, total_euclidean, delta_x_world_units_to_exit_start_tile, delta_y_world_units_to_exit_start_tile = RC.cast_ray_continous_world(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
            Test.@test i_stop == 5
            Test.@test j_stop == 2
            Test.@test hit_dimension == 1
            Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
            Test.@test delta_x_world_units_to_exit_start_tile ≈ 0.5
            Test.@test delta_y_world_units_to_exit_start_tile ≈ 0.5
        end
    end

    Test.@testset "Discrete world" begin
        I = Int
        world_units_per_tile_unit = convert(I, 256)

        i_start_world_units = convert(I, height_obstacle_tile_map * world_units_per_tile_unit ÷ 2 + 1)
        j_start_world_units = convert(I, width_obstacle_tile_map * world_units_per_tile_unit ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, 0)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 3)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            delta_i_world_units = convert(I, 2)
            delta_j_world_units = convert(I, 1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, 1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, 2)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 4)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            delta_i_world_units = convert(I, 0)
            delta_j_world_units = convert(I, 1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 3)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, 2)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 2)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, 1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 2)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            delta_i_world_units = convert(I, -2)
            delta_j_world_units = convert(I, 1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, 0)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 3)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            delta_i_world_units = convert(I, -2)
            delta_j_world_units = convert(I, -1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, -1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, -2)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 2)
            Test.@test j_stop_tile_units == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            delta_i_world_units = convert(I, 0)
            delta_j_world_units = convert(I, -1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 3)
            Test.@test j_stop_tile_units == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, -2)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 4)
            Test.@test j_stop_tile_units == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, -1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            delta_i_world_units = convert(I, 2)
            delta_j_world_units = convert(I, -1)
            i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray_discrete_world(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
        end
    end
end
