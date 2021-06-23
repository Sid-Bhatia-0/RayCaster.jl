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

    T1 = Float32
    T2 = Float32

    x_start = convert(T1, 5 / 2)
    y_start = convert(T1, 5 / 2)

    Test.@testset "theta = 0" begin
        theta = convert(T2, 0)
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 5
        Test.@test j_stop == 3
        Test.@test hit_dimension == 1
        Test.@test total_euclidean ≈ 1.5
    end

    Test.@testset "theta = atan(2 / 3)" begin
        theta = convert(T2, atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 5
        Test.@test j_stop == 4
        Test.@test hit_dimension == 1
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end

    Test.@testset "theta = (pi / 2) - atan(2 / 3)" begin
        theta = convert(T2, (pi / 2) - atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 4
        Test.@test j_stop == 5
        Test.@test hit_dimension == 2
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end

    Test.@testset "theta = pi / 2" begin
        theta = convert(T2, pi / 2)
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 3
        Test.@test j_stop == 5
        Test.@test hit_dimension == 2
        Test.@test total_euclidean ≈ 1.5
    end

    Test.@testset "theta = (pi / 2) + atan(2 / 3)" begin
        theta = convert(T2, (pi / 2) + atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 2
        Test.@test j_stop == 5
        Test.@test hit_dimension == 2
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end

    Test.@testset "theta = pi - atan(2 / 3)" begin
        theta = convert(T2, pi - atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 1
        Test.@test j_stop == 4
        Test.@test hit_dimension == 1
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end

    Test.@testset "theta = pi" begin
        theta = convert(T2, pi)
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 1
        Test.@test j_stop == 3
        Test.@test hit_dimension == 1
        Test.@test total_euclidean ≈ 1.5
    end

    Test.@testset "theta = pi + atan(2 / 3)" begin
        theta = convert(T2, pi + atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 1
        Test.@test j_stop == 2
        Test.@test hit_dimension == 1
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end

    Test.@testset "theta = (3 * pi / 2) - atan(2 / 3)" begin
        theta = convert(T2, (3 * pi / 2) - atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 2
        Test.@test j_stop == 1
        Test.@test hit_dimension == 2
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end

    Test.@testset "theta = 3 * pi / 2" begin
        theta = convert(T2, 3 * pi / 2)
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 3
        Test.@test j_stop == 1
        Test.@test hit_dimension == 2
        Test.@test total_euclidean ≈ 1.5
    end

    Test.@testset "theta = (3 * pi / 2) + atan(2 / 3)" begin
        theta = convert(T2, (3 * pi / 2) + atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 4
        Test.@test j_stop == 1
        Test.@test hit_dimension == 2
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end

    Test.@testset "theta = 2 * pi - atan(2 / 3)" begin
        theta = convert(T2, 2 * pi - atan(2 / 3))
        cos_theta = cos(theta)
        sin_theta = sin(theta)
        i_stop, j_stop, hit_dimension, total_euclidean = RC.cast_ray(obstacle_tile_map, x_start, y_start, cos_theta, sin_theta)
        Test.@test i_stop == 5
        Test.@test j_stop == 2
        Test.@test hit_dimension == 1
        Test.@test total_euclidean ≈ sqrt(1.5 ^ 2 + 1 ^ 2)
    end
end
