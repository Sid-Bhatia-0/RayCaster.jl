import RayCaster as RC
import Test

test_ray_stop(division_style::RC.RationalDivision, x_ray_stop_computed, x_ray_stop_actual) = x_ray_stop_computed == convert(Rational, x_ray_stop_actual)
test_ray_stop(division_style::RC.FloatDivision, x_ray_stop_computed, x_ray_stop_actual) = x_ray_stop_computed ≈ convert(Float64, x_ray_stop_actual)

Test.@testset "RayCaster.jl" begin
    obstacle_tile_map = BitArray([
                                  1 1 1 1 1
                                  1 0 0 0 1
                                  1 0 1 0 1
                                  1 0 0 0 1
                                  1 1 1 1 1
                                 ])

    max_steps = 1024
    I = Int
    Test.@testset "I = $(I), max_steps = $(max_steps), division_style = $(division_style)" for division_style in [RC.RATIONAL_DIVISION, RC.FLOAT_DIVISION]

        tile_length = convert(I, 8)
        Test.@testset "tile_length = $(tile_length)" begin

            i_ray_start_tile = convert(I, 2)
            j_ray_start_tile = convert(I, 2)
            Test.@testset "i_ray_start_tile = $(i_ray_start_tile), j_ray_start_tile = $(j_ray_start_tile)" begin

                x_ray_start_relative_to_tile = convert(I, 1)
                y_ray_start_relative_to_tile = convert(I, 1)
                x_ray_start = RC.get_tile_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile)
                y_ray_start = RC.get_tile_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile)
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 33)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 2)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 17)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 17)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 33)
                        Test.@test i_ray_hit_tile == convert(I, 2)
                        Test.@test j_ray_hit_tile == convert(I, 5)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 1)
                        Test.@test j_ray_hit_tile == convert(I, 2)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 1)
                        Test.@test j_ray_hit_tile == convert(I, 2)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 1)
                        Test.@test j_ray_hit_tile == convert(I, 2)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 2)
                        Test.@test j_ray_hit_tile == convert(I, 1)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 2)
                        Test.@test j_ray_hit_tile == convert(I, 1)
                        Test.@test hit_dimension == 2
                    end
                end

                x_ray_start_relative_to_tile = convert(I, 9)
                y_ray_start_relative_to_tile = convert(I, 5)
                x_ray_start = RC.get_tile_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile)
                y_ray_start = RC.get_tile_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile)
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 17)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 17)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 2
                    end
                end

                x_ray_start_relative_to_tile = convert(I, 5)
                y_ray_start_relative_to_tile = convert(I, 9)
                x_ray_start = RC.get_tile_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile)
                y_ray_start = RC.get_tile_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile)
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 17)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 17)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 1
                    end
                end
            end

            i_ray_start_tile = convert(I, 4)
            j_ray_start_tile = convert(I, 4)
            Test.@testset "i_ray_start_tile = $(i_ray_start_tile), j_ray_start_tile = $(j_ray_start_tile)" begin

                x_ray_start_relative_to_tile = convert(I, 1)
                y_ray_start_relative_to_tile = convert(I, 1)
                x_ray_start = RC.get_tile_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile)
                y_ray_start = RC.get_tile_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile)
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 33)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 25)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 3)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 33)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 83//3)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 33)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 33)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 83//3)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 33)
                        Test.@test i_ray_hit_tile == convert(I, 4)
                        Test.@test j_ray_hit_tile == convert(I, 5)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 25)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 33)
                        Test.@test i_ray_hit_tile == convert(I, 4)
                        Test.@test j_ray_hit_tile == convert(I, 5)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 67//3)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 33)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 5)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 17)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 33)
                        Test.@test i_ray_hit_tile == convert(I, 2)
                        Test.@test j_ray_hit_tile == convert(I, 5)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -3)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 91//3)
                        Test.@test i_ray_hit_tile == convert(I, 1)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 9)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 25)
                        Test.@test i_ray_hit_tile == convert(I, 1)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -3)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 25)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 25)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 25)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 25)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 25)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 25)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 25)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 4)
                        Test.@test j_ray_hit_tile == convert(I, 1)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 91//3)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 9)
                        Test.@test i_ray_hit_tile == convert(I, 4)
                        Test.@test j_ray_hit_tile == convert(I, 1)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 33)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 17)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 3)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 33)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 67//3)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 1
                    end
                end
            end
        end

        tile_length = convert(I, 1)
        Test.@testset "tile_length = $(tile_length)" begin

            i_ray_start_tile = convert(I, 4)
            j_ray_start_tile = convert(I, 4)
            Test.@testset "i_ray_start_tile = $(i_ray_start_tile), j_ray_start_tile = $(j_ray_start_tile)" begin

                x_ray_start_relative_to_tile = convert(I, 1)
                y_ray_start_relative_to_tile = convert(I, 1)
                x_ray_start = RC.get_tile_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile)
                y_ray_start = RC.get_tile_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile)
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 5)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 4)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 5)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 5)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 4)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 5)
                        Test.@test i_ray_hit_tile == convert(I, 4)
                        Test.@test j_ray_hit_tile == convert(I, 5)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 3)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 5)
                        Test.@test i_ray_hit_tile == convert(I, 2)
                        Test.@test j_ray_hit_tile == convert(I, 5)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 2)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 4)
                        Test.@test i_ray_hit_tile == convert(I, 1)
                        Test.@test j_ray_hit_tile == convert(I, 4)
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 4)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 4)
                        Test.@test i_ray_hit_tile == convert(I, 3)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 4)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 2)
                        Test.@test i_ray_hit_tile == convert(I, 4)
                        Test.@test j_ray_hit_tile == convert(I, 1)
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop, y_ray_stop, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps, division_style)
                        Test.@test test_ray_stop(division_style, x_ray_stop, 5)
                        Test.@test test_ray_stop(division_style, y_ray_stop, 3)
                        Test.@test i_ray_hit_tile == convert(I, 5)
                        Test.@test j_ray_hit_tile == convert(I, 3)
                        Test.@test hit_dimension == 1
                    end
                end
            end
        end
    end
end
