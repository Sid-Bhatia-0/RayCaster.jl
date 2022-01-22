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
    division_style = RC.RATIONAL_DIVISION
    I = Int

    Test.@testset "tile_length = 8" begin
        tile_length = convert(I, 8)

        x_ray_start = convert(I, (height_obstacle_tile_map * tile_length) ÷ 2 + 1)
        y_ray_start = convert(I, (width_obstacle_tile_map * tile_length) ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 0)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 33)
            Test.@test j_ray_stop == convert(Rational, 21)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 33)
            Test.@test j_ray_stop == convert(Rational, 27)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 33)
            Test.@test j_ray_stop == convert(Rational, 33)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 27)
            Test.@test j_ray_stop == convert(Rational, 33)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 21)
            Test.@test j_ray_stop == convert(Rational, 33)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 15)
            Test.@test j_ray_stop == convert(Rational, 33)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 9)
            Test.@test j_ray_stop == convert(Rational, 33)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 9)
            Test.@test j_ray_stop == convert(Rational, 27)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 0)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 9)
            Test.@test j_ray_stop == convert(Rational, 21)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 9)
            Test.@test j_ray_stop == convert(Rational, 15)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 9)
            Test.@test j_ray_stop == convert(Rational, 9)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 15)
            Test.@test j_ray_stop == convert(Rational, 9)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 21)
            Test.@test j_ray_stop == convert(Rational, 9)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 27)
            Test.@test j_ray_stop == convert(Rational, 9)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 33)
            Test.@test j_ray_stop == convert(Rational, 9)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 33)
            Test.@test j_ray_stop == convert(Rational, 15)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end
    end

    Test.@testset "tile_length = 1" begin
        tile_length = convert(I, 1)

        x_ray_start = convert(I, (height_obstacle_tile_map * tile_length) ÷ 2 + 1)
        y_ray_start = convert(I, (width_obstacle_tile_map * tile_length) ÷ 2 + 1)

        Test.@testset "delta_i = 1, delta_j = 0" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 0)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 5)
            Test.@test j_ray_stop == convert(Rational, 3)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 2, delta_j = 1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 5)
            Test.@test j_ray_stop == convert(Rational, 4)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 5)
            Test.@test j_ray_stop == convert(Rational, 5)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = 1, delta_j = 2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, 2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 4)
            Test.@test j_ray_stop == convert(Rational, 5)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = 1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 3)
            Test.@test j_ray_stop == convert(Rational, 5)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 5)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = -1, delta_j = 2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 2)
            Test.@test j_ray_stop == convert(Rational, 5)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 4)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = 1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 2)
            Test.@test j_ray_stop == convert(Rational, 4)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = 1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, 1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 2)
            Test.@test j_ray_stop == convert(Rational, 7//2)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = 0" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, 0)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 2)
            Test.@test j_ray_stop == convert(Rational, 3)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 3)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -2, delta_j = -1" begin
            i_ray_direction = convert(I, -2)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 2)
            Test.@test j_ray_stop == convert(Rational, 5//2)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -1" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 2)
            Test.@test j_ray_stop == convert(Rational, 2)
            Test.@test i_ray_hit_tile == convert(I, 1)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end

        Test.@testset "delta_i = -1, delta_j = -2" begin
            i_ray_direction = convert(I, -1)
            j_ray_direction = convert(I, -2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 5//2)
            Test.@test j_ray_stop == convert(Rational, 2)
            Test.@test i_ray_hit_tile == convert(I, 2)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 0, delta_j = -1" begin
            i_ray_direction = convert(I, 0)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 3)
            Test.@test j_ray_stop == convert(Rational, 2)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -2" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -2)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 7//2)
            Test.@test j_ray_stop == convert(Rational, 2)
            Test.@test i_ray_hit_tile == convert(I, 3)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 1, delta_j = -1" begin
            i_ray_direction = convert(I, 1)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 4)
            Test.@test j_ray_stop == convert(Rational, 2)
            Test.@test i_ray_hit_tile == convert(I, 4)
            Test.@test j_ray_hit_tile == convert(I, 1)
            Test.@test hit_dimension == 2
        end

        Test.@testset "delta_i = 2, delta_j = -1" begin
            i_ray_direction = convert(I, 2)
            j_ray_direction = convert(I, -1)
            i_ray_stop, j_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, i_ray_direction, j_ray_direction, max_steps, division_style)
            Test.@test i_ray_stop == convert(Rational, 5)
            Test.@test j_ray_stop == convert(Rational, 2)
            Test.@test i_ray_hit_tile == convert(I, 5)
            Test.@test j_ray_hit_tile == convert(I, 2)
            Test.@test hit_dimension == 1
        end
    end

    Test.@testset "cast_ray_1d" begin
        obstacle_tile_map = BitArray([1, 0, 0, 0, 1])
        max_steps = 1024
        I = Int
        tile_length = convert(I, 8)
        x_ray_start = convert(I, 25)
        i_ray_start_tile = convert(I, 4)

        Test.@testset "tile_length = 8" begin
            tile_length = convert(I, 8)

            Test.@testset "x_ray_start = 25" begin
                x_ray_start = convert(I, 25)

                Test.@testset "i_ray_direction = 2" begin
                    i_ray_direction = convert(I, 2)
                    i_ray_stop, i_ray_hit_tile = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, i_ray_start_tile, i_ray_direction, max_steps)
                    Test.@test i_ray_stop == convert(I, 33)
                    Test.@test i_ray_hit_tile == convert(I, 5)
                end

                Test.@testset "i_ray_direction = -2" begin
                    i_ray_direction = convert(I, -2)
                    i_ray_stop, i_ray_hit_tile = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, i_ray_start_tile, i_ray_direction, max_steps)
                    Test.@test i_ray_stop == convert(I, 9)
                    Test.@test i_ray_hit_tile == convert(I, 1)
                end
            end

            Test.@testset "x_ray_start = 29" begin
                x_ray_start = convert(I, 29)

                Test.@testset "i_ray_direction = 2" begin
                    i_ray_direction = convert(I, 2)
                    i_ray_stop, i_ray_hit_tile = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, i_ray_start_tile, i_ray_direction, max_steps)
                    Test.@test i_ray_stop == convert(I, 33)
                    Test.@test i_ray_hit_tile == convert(I, 5)
                end

                Test.@testset "i_ray_direction = -2" begin
                    i_ray_direction = convert(I, -2)
                    i_ray_stop, i_ray_hit_tile = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, i_ray_start_tile, i_ray_direction, max_steps)
                    Test.@test i_ray_stop == convert(I, 9)
                    Test.@test i_ray_hit_tile == convert(I, 1)
                end
            end
        end
    end
end
