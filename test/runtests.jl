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
    max_steps = 1024
    I = Int

    Test.@testset "cells_per_tile_1d = 8" begin
        cells_per_tile_1d = convert(I, 8)

        i_ray_start_cell = convert(I, height_obstacle_tile_map * cells_per_tile_1d ÷ 2 + 1)
        j_ray_start_cell = convert(I, width_obstacle_tile_map * cells_per_tile_1d ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 0)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 33)
            Test.@test j_ray_stop_cell == convert(I, 21)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 33)
            Test.@test j_ray_stop_cell == convert(I, 27)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 33)
            Test.@test j_ray_stop_cell == convert(I, 32)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 27)
            Test.@test j_ray_stop_cell == convert(I, 33)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 21)
            Test.@test j_ray_stop_cell == convert(I, 33)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 15)
            Test.@test j_ray_stop_cell == convert(I, 33)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 9)
            Test.@test j_ray_stop_cell == convert(I, 32)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 9)
            Test.@test j_ray_stop_cell == convert(I, 27)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 0)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 9)
            Test.@test j_ray_stop_cell == convert(I, 21)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 9)
            Test.@test j_ray_stop_cell == convert(I, 15)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 9)
            Test.@test j_ray_stop_cell == convert(I, 9)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 15)
            Test.@test j_ray_stop_cell == convert(I, 9)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 21)
            Test.@test j_ray_stop_cell == convert(I, 9)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 27)
            Test.@test j_ray_stop_cell == convert(I, 9)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 33)
            Test.@test j_ray_stop_cell == convert(I, 9)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 33)
            Test.@test j_ray_stop_cell == convert(I, 15)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end
    end

    Test.@testset "cells_per_tile_1d = 9" begin
        cells_per_tile_1d = convert(I, 9)

        i_ray_start_cell = convert(I, (height_obstacle_tile_map * cells_per_tile_1d) ÷ 2 + 1)
        j_ray_start_cell = convert(I, (width_obstacle_tile_map * cells_per_tile_1d) ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 0)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 37)
            Test.@test j_ray_stop_cell == convert(I, 23)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 37)
            Test.@test j_ray_stop_cell == convert(I, 30)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 37)
            Test.@test j_ray_stop_cell == convert(I, 36)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 30)
            Test.@test j_ray_stop_cell == convert(I, 37)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 23)
            Test.@test j_ray_stop_cell == convert(I, 37)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 16)
            Test.@test j_ray_stop_cell == convert(I, 37)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 10)
            Test.@test j_ray_stop_cell == convert(I, 36)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 10)
            Test.@test j_ray_stop_cell == convert(I, 29)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 0)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 10)
            Test.@test j_ray_stop_cell == convert(I, 23)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 10)
            Test.@test j_ray_stop_cell == convert(I, 17)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 10)
            Test.@test j_ray_stop_cell == convert(I, 10)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 17)
            Test.@test j_ray_stop_cell == convert(I, 10)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 23)
            Test.@test j_ray_stop_cell == convert(I, 10)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 29)
            Test.@test j_ray_stop_cell == convert(I, 10)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 36)
            Test.@test j_ray_stop_cell == convert(I, 10)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 37)
            Test.@test j_ray_stop_cell == convert(I, 16)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end
    end

    Test.@testset "cells_per_tile_1d = 1" begin
        cells_per_tile_1d = convert(I, 1)

        i_ray_start_cell = convert(I, (height_obstacle_tile_map * cells_per_tile_1d) ÷ 2 + 1)
        j_ray_start_cell = convert(I, (width_obstacle_tile_map * cells_per_tile_1d) ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 0)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 5)
            Test.@test j_ray_stop_cell == convert(I, 3)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 5)
            Test.@test j_ray_stop_cell == convert(I, 3)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 5)
            Test.@test j_ray_stop_cell == convert(I, 4)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 4)
            Test.@test j_ray_stop_cell == convert(I, 5)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 3)
            Test.@test j_ray_stop_cell == convert(I, 5)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 2)
            Test.@test j_ray_stop_cell == convert(I, 4)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 2)
            Test.@test j_ray_stop_cell == convert(I, 3)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, 1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 2)
            Test.@test j_ray_stop_cell == convert(I, 3)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 0)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 2)
            Test.@test j_ray_stop_cell == convert(I, 3)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 2)
            Test.@test j_ray_stop_cell == convert(I, 2)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 2)
            Test.@test j_ray_stop_cell == convert(I, 2)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 2)
            Test.@test j_ray_stop_cell == convert(I, 2)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 3)
            Test.@test j_ray_stop_cell == convert(I, 2)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -2)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 3)
            Test.@test j_ray_stop_cell == convert(I, 2)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 4)
            Test.@test j_ray_stop_cell == convert(I, 2)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, -1)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 5)
            Test.@test j_ray_stop_cell == convert(I, 2)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end
    end

    Test.@testset "starting inside an obstacle tile" begin
        cells_per_tile_1d = convert(I, 8)

        i_ray_start_cell = convert(I, 3)
        j_ray_start_cell = convert(I, 4)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 0)
            i_ray_stop_cell, j_ray_stop_cell, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, cells_per_tile_1d, i_ray_start_cell, j_ray_start_cell, i_ray_direction, j_ray_direction, max_steps)
            Test.@test i_ray_stop_cell == convert(I, 3)
            Test.@test j_ray_stop_cell == convert(I, 4)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 0
        end
    end
end
