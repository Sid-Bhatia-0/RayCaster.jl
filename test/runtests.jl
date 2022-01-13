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

    Test.@testset "Discrete world" begin
        I = Int
        world_units_per_tile_unit = convert(I, 256)

        i_start_world_units = convert(I, height_obstacle_tile_map * world_units_per_tile_unit ÷ 2 + 1)
        j_start_world_units = convert(I, width_obstacle_tile_map * world_units_per_tile_unit ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, 0)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 3)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            delta_i_world_units = convert(I, 2)
            delta_j_world_units = convert(I, 1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, 1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, 2)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 4)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            delta_i_world_units = convert(I, 0)
            delta_j_world_units = convert(I, 1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 3)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, 2)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 2)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, 1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 2)
            Test.@test j_stop_tile_units == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            delta_i_world_units = convert(I, -2)
            delta_j_world_units = convert(I, 1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, 0)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 3)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            delta_i_world_units = convert(I, -2)
            delta_j_world_units = convert(I, -1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, -1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 1)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            delta_i_world_units = convert(I, -1)
            delta_j_world_units = convert(I, -2)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 2)
            Test.@test j_stop_tile_units == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            delta_i_world_units = convert(I, 0)
            delta_j_world_units = convert(I, -1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 3)
            Test.@test j_stop_tile_units == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, -2)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 4)
            Test.@test j_stop_tile_units == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            delta_i_world_units = convert(I, 1)
            delta_j_world_units = convert(I, -1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            delta_i_world_units = convert(I, 2)
            delta_j_world_units = convert(I, -1)
            i_start_tile_units, j_start_tile_units, i_stop_tile_units, j_stop_tile_units, hit_dimension, delta_i_world_units_to_exit_start_tile, delta_j_world_units_to_exit_start_tile = RC.cast_ray(obstacle_tile_map, i_start_world_units, j_start_world_units, delta_i_world_units, delta_j_world_units, world_units_per_tile_unit)
            Test.@test i_stop_tile_units == convert(I, 5)
            Test.@test j_stop_tile_units == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test delta_i_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test delta_j_world_units_to_exit_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_start_tile_units == convert(I, 3)
            Test.@test j_start_tile_units == convert(I, 3)
        end
    end
end
