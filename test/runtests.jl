import RayCaster as RC
import Test

Test.@testset "RayCaster.jl" begin
    obstacle_tile_map = BitArray([
                                  1 1 1 1 1
                                  1 0 0 0 1
                                  1 0 1 0 1
                                  1 0 0 0 1
                                  1 1 1 1 1
                                 ])

    max_steps = 1024
    Test.@testset "I = $(I), max_steps = $(max_steps)" for I in [Int, Int32]

        tile_length = convert(I, 8)
        Test.@testset "tile_length = $(tile_length)" begin

            i_ray_start_tile = convert(I, 2)
            j_ray_start_tile = convert(I, 2)
            Test.@testset "i_ray_start_tile = $(i_ray_start_tile), j_ray_start_tile = $(j_ray_start_tile)" begin

                x_ray_start_relative_to_tile = convert(I, 1)
                y_ray_start_relative_to_tile = convert(I, 1)
                x_ray_start = convert(I, RC.get_segment_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile))
                y_ray_start = convert(I, RC.get_segment_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile))
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 2
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 2
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 1
                        Test.@test j_ray_hit_tile == 2
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 1
                        Test.@test j_ray_hit_tile == 2
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 1
                        Test.@test j_ray_hit_tile == 2
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 2
                        Test.@test j_ray_hit_tile == 1
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 2
                        Test.@test j_ray_hit_tile == 1
                        Test.@test hit_dimension == 2
                    end
                end

                x_ray_start_relative_to_tile = convert(I, 9)
                y_ray_start_relative_to_tile = convert(I, 5)
                x_ray_start = convert(I, RC.get_segment_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile))
                y_ray_start = convert(I, RC.get_segment_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile))
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end
                end

                x_ray_start_relative_to_tile = convert(I, 5)
                y_ray_start_relative_to_tile = convert(I, 9)
                x_ray_start = convert(I, RC.get_segment_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile))
                y_ray_start = convert(I, RC.get_segment_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile))
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 1
                    end
                end
            end

            i_ray_start_tile = convert(I, 4)
            j_ray_start_tile = convert(I, 4)
            Test.@testset "i_ray_start_tile = $(i_ray_start_tile), j_ray_start_tile = $(j_ray_start_tile)" begin

                x_ray_start_relative_to_tile = convert(I, 1)
                y_ray_start_relative_to_tile = convert(I, 1)
                x_ray_start = convert(I, RC.get_segment_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile))
                y_ray_start = convert(I, RC.get_segment_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile))
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 3)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 83//3)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 83//3)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 67//3)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 2
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -3)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 91//3)
                        Test.@test i_ray_hit_tile == 1
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 1
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -3)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 1
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -3)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 91//3)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 9//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 1
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 17//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 3)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 67//3)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 3
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
                x_ray_start = convert(I, RC.get_segment_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile))
                y_ray_start = convert(I, RC.get_segment_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile))
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 5//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 4//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 5//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 5//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 4//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 5//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 3//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 5//1)
                        Test.@test i_ray_hit_tile == 2
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 2//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 4//1)
                        Test.@test i_ray_hit_tile == 1
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 4//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 4//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 4//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 2//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 1
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 5//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 3//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 1
                    end
                end
            end
        end

        tile_length = convert(I, 256)
        Test.@testset "tile_length = $(tile_length)" begin

            i_ray_start_tile = convert(I, 2)
            j_ray_start_tile = convert(I, 2)
            Test.@testset "i_ray_start_tile = $(i_ray_start_tile), j_ray_start_tile = $(j_ray_start_tile)" begin

                x_ray_start_relative_to_tile = convert(I, tile_length ÷ 2 + 1)
                y_ray_start_relative_to_tile = convert(I, tile_length ÷ 2 + 1)
                x_ray_start = convert(I, RC.get_segment_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile))
                y_ray_start = convert(I, RC.get_segment_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile))
                Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                    x_direction = convert(I, 1)
                    y_direction = convert(I, 1)
                    semi_field_of_view_ratio = 2//3
                    num_rays = 9
                    Test.@testset "x_direction = $(x_direction), y_direction = $(y_direction)" begin
                        outputs = Vector{Tuple{I, I, I, I, I, I, Int, I, I}}(undef, num_rays)
                        RC.cast_rays!(outputs, obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_direction, y_direction, semi_field_of_view_ratio, max_steps, i_ray_start_tile, j_ray_start_tile)
                    end
                end
            end
        end
    end

    obstacle_tile_map = BitArray([
                                  1 1 1 1 1 1 1 1
                                  1 0 0 0 0 0 0 1
                                  1 0 0 0 0 0 0 1
                                  1 0 0 0 0 0 0 1
                                  1 0 0 0 0 0 0 1
                                  1 0 0 0 0 0 0 1
                                  1 0 0 0 0 0 0 1
                                  1 1 1 1 1 1 1 1
                                 ])

    I = Int
    tile_length = convert(I, 8)
    Test.@testset "tile_length = $(tile_length)" begin

        i_ray_start_tile = convert(I, 5)
        j_ray_start_tile = convert(I, 5)
        Test.@testset "i_ray_start_tile = $(i_ray_start_tile), j_ray_start_tile = $(j_ray_start_tile)" begin

            x_ray_start_relative_to_tile = convert(I, 1)
            y_ray_start_relative_to_tile = convert(I, 1)
            x_ray_start = convert(I, RC.get_segment_start(i_ray_start_tile, tile_length) + x_ray_start_relative_to_tile - one(x_ray_start_relative_to_tile))
            y_ray_start = convert(I, RC.get_segment_start(j_ray_start_tile, tile_length) + y_ray_start_relative_to_tile - one(y_ray_start_relative_to_tile))
            Test.@testset "x_ray_start = $(x_ray_start), y_ray_start = $(y_ray_start)" begin

                max_steps = 1
                Test.@testset "max_steps = $(max_steps)" begin
                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 41//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 6
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 41//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 41//1)
                        Test.@test i_ray_hit_tile == 6
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 41//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 6
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 4
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 2
                    end
                end

                max_steps = 2
                Test.@testset "max_steps = $(max_steps)" begin
                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 49//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 7
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 49//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 49//1)
                        Test.@test i_ray_hit_tile == 7
                        Test.@test j_ray_hit_tile == 6
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 49//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 7
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 41//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, 0)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 5
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, -1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 3
                        Test.@test j_ray_hit_tile == 4
                        Test.@test hit_dimension == 1
                    end

                    x_ray_direction = convert(I, 0)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 33//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 5
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end

                    x_ray_direction = convert(I, 1)
                    y_ray_direction = convert(I, -1)
                    Test.@testset "x_ray_direction = $(x_ray_direction), y_ray_direction = $(y_ray_direction)" begin
                        x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)
                        Test.@test x_ray_stop_numerator//x_ray_stop_denominator === convert(Rational{I}, 41//1)
                        Test.@test y_ray_stop_numerator//y_ray_stop_denominator === convert(Rational{I}, 25//1)
                        Test.@test i_ray_hit_tile == 6
                        Test.@test j_ray_hit_tile == 3
                        Test.@test hit_dimension == 2
                    end
                end
            end
        end
    end
end
