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

        i_ray_start_cell = convert(I, height_obstacle_tile_map * world_units_per_tile_unit ÷ 2 + 1)
        j_ray_start_cell = convert(I, width_obstacle_tile_map * world_units_per_tile_unit ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 0)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 5)
            Test.@test j_ray_stop_tile == convert(I, 3)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, 1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 5)
            Test.@test j_ray_stop_tile == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 5)
            Test.@test j_ray_stop_tile == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 2)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 4)
            Test.@test j_ray_stop_tile == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, 1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 3)
            Test.@test j_ray_stop_tile == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 2)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 2)
            Test.@test j_ray_stop_tile == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 2)
            Test.@test j_ray_stop_tile == convert(I, 5)
            Test.@test hit_dimension == 2
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, 1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 1)
            Test.@test j_ray_stop_tile == convert(I, 4)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 0)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 1)
            Test.@test j_ray_stop_tile == convert(I, 3)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, -1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 1)
            Test.@test j_ray_stop_tile == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 1)
            Test.@test j_ray_stop_tile == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -2)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 2)
            Test.@test j_ray_stop_tile == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, -1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 3)
            Test.@test j_ray_stop_tile == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -2)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 4)
            Test.@test j_ray_stop_tile == convert(I, 1)
            Test.@test hit_dimension == 2
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 5)
            Test.@test j_ray_stop_tile == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, -1)
            i_ray_start_tile, j_ray_start_tile, i_ray_stop_tile, j_ray_stop_tile, hit_dimension, cells_travelled_along_i_axis_to_exit_ray_start_tile, cells_travelled_along_j_axis_to_exit_ray_start_tile = RC.cast_ray(obstacle_tile_map, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, world_units_per_tile_unit)
            Test.@test i_ray_stop_tile == convert(I, 5)
            Test.@test j_ray_stop_tile == convert(I, 2)
            Test.@test hit_dimension == 1
            Test.@test cells_travelled_along_i_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2
            Test.@test cells_travelled_along_j_axis_to_exit_ray_start_tile == world_units_per_tile_unit ÷ 2 + 1
            Test.@test i_ray_start_tile == convert(I, 3)
            Test.@test j_ray_start_tile == convert(I, 3)
        end
    end
end
