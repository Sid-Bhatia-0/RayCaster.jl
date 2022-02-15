# RayCaster

This package provides a fast and exact (integer-based) implementation of 2D ray casting.

## Table of contents:

* [Getting Started](#getting-started)
* [Example](#example)
* [Notes](#notes)
  - [API](#api)
  - [Integer-based computations](#integer-based-computations)
  - [Returning numerators and denominators separately](#returning-numerators-and-denominators-separately)
* [Benchmarks](#benchmarks)
* [Useful References](#useful-references)

## Getting started

```julia
import RayCaster as RC

# we have a finite 2D world
# this world is discretized using a tile map into a grid of square tiles
# the x-axis of the world corresponds to the i-axis (first dimension) of the tile map
# the y-axis of the world corresponds to the j-axis (second dimension) of the tile map
# the side length of each tile is an integer value in the world units
# the tile map is aligned with the fine-grained lattice formed by all integer coordinates of the world
# so the top-left corner of the first tile is at (1, 1) and bottom-right corner is (tile_length + 1, tile_length + 1) where tile_length is an integer
# the top left corner of the tile map is at world coordinate (1, 1)
tile_length = 8

# let's say we have the following tile map for our world
# 1 means that the tile contains an obstacle (it will not allow a ray to pass through it)
# 0 means that the tile is empty (it will allow a ray to pass through it)
obstacle_tile_map = BitArray([
                              1 1 1 1 1
                              1 0 0 0 1
                              1 0 0 0 1
                              1 0 0 0 1
                              1 1 1 1 1
                             ])

height_obstacle_tile_map = size(obstacle_tile_map, 1)
width_obstacle_tile_map = size(obstacle_tile_map, 2)

# let us say our current position is at the center of the tile (2, 2), which is at world coordinates (13, 13)
# this is the position from where we start casting our rays
x_ray_start = 13
y_ray_start = 13

# we will cast a ray at an angle of atan(y_ray_direction, x_ray_direction) with the positive i-axis (positive x-axis)
# both x_ray_direction and y_ray_direction are integers
x_ray_direction = 3
y_ray_direction = 1

# our ray will stop when it encounters a tile containing an obstacle or when the number of steps taken exceeds max_steps
# one step corresponds to one tile move along the i-axis or the j-axis
max_steps = 1024

# upon casting the ray, we obtain the following output
x_ray_stop_numerator, x_ray_stop_denominator, y_ray_stop_numerator, y_ray_stop_denominator, i_ray_hit_tile, j_ray_hit_tile, hit_dimension = RC.cast_ray(obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, max_steps)

# x_ray_stop_numerator (an integer) is the numerator of the x-coordinate (in world units) of the point where the ray stops 
# x_ray_stop_denominator (an integer) is the denominator of the x-coordinate (in world units) of the point where the ray stops
# so the x-coordinate of the point where the ray stopped is given by (x_ray_stop_numerator / x_ray_stop_denominator)

# similarly...
# y_ray_stop_numerator (an integer) is the numerator of the y-coordinate (in world units) of the point where the ray stops 
# y_ray_stop_denominator (an integer) is the denominator of the y-coordinate (in world units) of the point where the ray stops
# so the y-coordinate of the point where the ray stopped is given by (y_ray_stop_numerator / y_ray_stop_denominator)

# (i_ray_hit_tile, j_ray_hit_tile) is the 2D index of the tile on the tile map that was hit by the ray
# under normal circumstances it will contain an obstacle
# if the number of steps taken exceeded max_steps, then the ray hit tile could also be empty

# hit_dimension gives the axis along which lies the surface normal for the tile that was hit by the ray
# 1 means that the surface whose normal was parallel to the i-axis
# 2 means that the surface whose normal was parallel to the j-axis

# we can use optionally use the SimpleDraw package to visualize the outputs of the above ray cast directly inside the terminal
import SimpleDraw as SD

# size of the world
height_world_map = height_obstacle_tile_map * tile_length
width_world_map = height_obstacle_tile_map * tile_length

# initialize a boolean image to render the top view of the world with one pixel per world unit square
image = falses(height_world_map, width_world_map)

# color with which to paint pixels in the boolean image
color = true

# draw the tile map
for j in axes(obstacle_tile_map, 2)
    for i in axes(obstacle_tile_map, 1)
        if obstacle_tile_map[i, j]
            SD.draw!(image, SD.Rectangle(SD.Point((i - 1) * tile_length + 1, (j - 1) * tile_length + 1), tile_length, tile_length), color)
        end
    end
end

# draw the ray
SD.draw!(image, SD.Line(SD.Point(x_ray_start, y_ray_start), SD.Point(div(x_ray_stop_numerator, x_ray_stop_denominator, RoundNearest), div(y_ray_stop_numerator, y_ray_stop_denominator, RoundNearest))), color)

@show height_obstacle_tile_map
@show width_obstacle_tile_map
@show tile_length
@show x_ray_start
@show y_ray_start
@show x_ray_direction
@show y_ray_direction
@show max_steps
@show x_ray_stop_numerator
@show x_ray_stop_denominator
@show y_ray_stop_numerator
@show y_ray_stop_denominator
@show i_ray_hit_tile
@show j_ray_hit_tile
@show hit_dimension

# visualize the cast ray
# in this visualization, a cell in the world (1 x 1 square unit region of the world) is represented by two consecutive unicode block characters (let's call this a block pixel)
# the block pixel indexed at (x, y) corresponds to the world coordinate (x, y) where both x and y are integers
# so if a ray starts at world coordinate (13, 13) then the block pixel indexed by (13, 13) will be lit up.
# the world coordinate corresponds to the top left corner of the block pixel.
SD.visualize(image)

# we can also cast multiple rays from the same starting point

# the number of rays that we want to cast
num_rays = 4

# allocate an array to store the outputs of all the ray casts
ray_cast_outputs = Vector{NTuple{9, Int}}(undef, num_rays)

# the angle of the entire field of view is 2 * atan(inv(semi_field_of_view_ratio))
semi_field_of_view_ratio = 2//1

# the direction of the camera normal (central direction most direction of all the rays) number of rays that we want to cast
x_camera_normal_direction = x_ray_direction
y_camera_normal_direction = y_ray_direction

# here is how we cast multiple rays
RC.cast_rays!(ray_cast_outputs, obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, semi_field_of_view_ratio, max_steps)
```

## Example

A complete ray-casting example is present in the `run_game.jl` script available in the `examples` directory.

Go inside the `examples` directory and run the following command:

```
 examples $ julia --project=. -e 'import Pkg; Pkg.instantiate(); include("run_game.jl")'
```

This will open a game window. You can use the arrow keys to navigate around in this game. Here is a screenshot:

<img src="https://user-images.githubusercontent.com/32610387/154131193-879c48c0-1856-4126-96d9-fc00934b7d46.png">

## Notes

### API

This package does not export any names. The `cast_ray` and `cast_rays!` functions can be considered as a part of the API. Everything else should be considered internal for now.

### Integer-based computations

Version `0.1.0` of this package used floating point numbers. However, I find integers to be easier to reason about than floating point numbers, and I can understand and cover all corner cases exactly. Also, in this case, I believe the precision offered by using 64-bit integers is enough for most applications. You can also use `SafeInt` from [SaferIntegers.jl](https://github.com/JeffreySarnoff/SaferIntegers.jl) to automatically check for overflow and underflow. This is a little slower than using `Int` (see [Benchmarks](#benchmarks)), but it might be okay for your application.

### Returning numerators and denominators separately

We return numerators and denominators of ray stop coordinates separately instead of just (numerator / denominator) or (numerator // denominator). With `x_ray_stop_numerator` and `x_ray_stop_denominator` being integers (similarly for `y`)
1. `x_ray_stop_numerator / x_ray_stop_denominator` would be a floating point number I want all the outputs to always be exact. Later the callee may choose to convert these to floating point numbers, but it should be by choice of the callee.
1. `x_ray_stop_numerator // x_ray_stop_denominator` would be an exact rational number, but constructing it will try to elimiate the greatest common diviser of the numerator and denominator internally. If the callee doesn't need that, then it is a unnecessary.

## Benchmarks

This package can be benchmarked using the `benchmark.jl` script available in the `perf` directory.

Go inside the `perf` directory and run the following command:

```
 perf $ julia --project=. -e 'import Pkg; Pkg.instantiate(); include("benchmark.jl")'
```

Here is an output generated using julia `v1.7.1`:

```text
...
... some project instantiation info when running for the first time
...
Julia Version 1.7.1
Commit ac5cc99908 (2021-12-22 19:35 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-12.0.1 (ORCJIT, skylake)

#######################################################
Integer type: Int64
#######################################################

height_obstacle_tile_map = 1024
width_obstacle_tile_map = 1024
tile_length = 256
x_ray_start = 131073
y_ray_start = 131073
x_ray_direction = 3
y_ray_direction = 1
max_steps = 1024
num_rays = 1024
semi_field_of_view_ratio = 2//1
x_camera_normal_direction = 3
y_camera_normal_direction = 1

Single ray cast:

BenchmarkTools.Trial: 10000 samples with 9 evaluations.
 Range (min … max):  2.073 μs …   5.962 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.079 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   2.145 μs ± 177.811 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  █▇▁          ▂▂            ▂▁             ▆▃              ▅ ▂
  ███▆▃▁▃▃▁▁▁▁▁██▄▄▃▁▄▃▁▁▁▁▁▁██▄▁▁▁▁▁▁▁▁▃▁▁▇██▆▅▅▄▅▃▄▃▁▁▁▄▁▇█ █
  2.07 μs      Histogram: log(frequency) by time      2.38 μs <

 Memory estimate: 0 bytes, allocs estimate: 0.

Multiple ray cast:

BenchmarkTools.Trial: 1989 samples with 1 evaluation.
 Range (min … max):  2.484 ms …  3.201 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.490 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   2.513 ms ± 56.807 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  █▆▂▂   ▆▄▂▃▁                                                
  █████▅▄██████▆▇▇▅▇▇▄▃▃▁▃▅▃▅▃▄▄▅▃▁▃▁▅▃▁▃▃▃▁▁▁▄▁▃▁▃▄▁▃▆▄▁▁▃▃ █
  2.48 ms      Histogram: log(frequency) by time     2.78 ms <

 Memory estimate: 0 bytes, allocs estimate: 0.

#######################################################
Integer type: SaferIntegers.SafeInt64
#######################################################

height_obstacle_tile_map = SaferIntegers.SafeInt64(1024)
width_obstacle_tile_map = SaferIntegers.SafeInt64(1024)
tile_length = SaferIntegers.SafeInt64(256)
x_ray_start = SaferIntegers.SafeInt64(131073)
y_ray_start = SaferIntegers.SafeInt64(131073)
x_ray_direction = SaferIntegers.SafeInt64(3)
y_ray_direction = SaferIntegers.SafeInt64(1)
max_steps = SaferIntegers.SafeInt64(1024)
num_rays = SaferIntegers.SafeInt64(1024)
semi_field_of_view_ratio = 2//1
x_camera_normal_direction = SaferIntegers.SafeInt64(3)
y_camera_normal_direction = SaferIntegers.SafeInt64(1)

Single ray cast:

BenchmarkTools.Trial: 10000 samples with 9 evaluations.
 Range (min … max):  2.574 μs …   7.239 μs  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     2.579 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   2.663 μs ± 262.205 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  █   ▃    ▃    ▅    ▄                                        ▁
  █▄▃▁█▇▆▅▅█▄▅▇▅█▁▁▄▅█▆▁▃▄▃▃▄▅▁▃▃▃▁▃▁▃▄▄▁▃▄▁▁▃▃▁▃▁▁▁▃▁▄▄▁▁▁▁▄ █
  2.57 μs      Histogram: log(frequency) by time      3.71 μs <

 Memory estimate: 0 bytes, allocs estimate: 0.

Multiple ray cast:

BenchmarkTools.Trial: 1583 samples with 1 evaluation.
 Range (min … max):  3.121 ms …  4.010 ms  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     3.159 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   3.158 ms ± 68.768 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

  █▆▁  ▄█▂▄  ▁                                                
  ███▇▁████▇▆█▆▇▆▄▇▄▅▇▄▄▄▅▄▄▄▄▄▄▄▄▄▄▆▄▄▁▁▁▁▁▁▁▁▁▄▁▄▁▆▆▄▁▁▄▁▄ █
  3.12 ms      Histogram: log(frequency) by time      3.5 ms <

 Memory estimate: 0 bytes, allocs estimate: 0.

```

## Useful references

1. https://lodev.org/cgtutor/raycasting.html
1. https://www.youtube.com/watch?v=NbSee-XM7WA
1. https://www.youtube.com/watch?v=gYRrGTC7GtA
