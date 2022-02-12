# RayCaster

This package provides a fast and exact (integer-based) implementation of 2D ray casting.

## Table of contents:

* [Getting Started](#getting-started)
* [Notes](#notes)
  - [API](#api)
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

# print the outputs
@show x_ray_stop_numerator
@show x_ray_stop_denominator
@show y_ray_stop_numerator
@show y_ray_stop_denominator
@show i_ray_hit_tile
@show j_ray_hit_tile
@show hit_dimension

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

# the semi field of view
semi_field_of_view_ratio = 1//1

# the direction of the camera normal (central direction most direction of all the rays) number of rays that we want to cast
x_camera_normal_direction = x_ray_direction
y_camera_normal_direction = y_ray_direction

# here is how we cast multiple rays
RC.cast_rays!(ray_cast_outputs, obstacle_tile_map, tile_length, x_ray_start, y_ray_start, x_ray_direction, y_ray_direction, semi_field_of_view_ratio, max_steps)
```

## Notes

### API

This package does not export any names. The `cast_ray` and `cast_rays!` functions can be considered as a part of the API. Everything else should be considered internal for now.

### Integer-based computations

Version `0.1.0` of this package used floating point numbers. However, I find integers to be easier to reason about than floating point numbers, and I can understand and cover all corner cases exactly. Also, in this case, I believe the precision offered by using 64-bit integers is enough for most applications. I haven't benchmarked the integer-based implementation with a floating point implementation, but I believe that that using integers does not worsen performance as compared to a similar implementation using floating point numbers, if at all.

### Why return numerators and denominators separately instead of just (numerator / denominator) or (numerator // denominator)

With `x_ray_stop_numerator` and `x_ray_stop_denominator` being integers
1. `x_ray_stop_numerator / x_ray_stop_denominator` would be a floating point number I want all the outputs to always be exact. Later the callee may choose to convert these to floating point numbers, but it should be by choice of the callee.
1. `x_ray_stop_numerator // x_ray_stop_denominator` would be an exact rational number, but constructing it will try to elimiate the greatest common diviser of the numerator and denominator internally. If the callee doesn't need that, then it is a unnecessary.

### Useful references

1. https://lodev.org/cgtutor/raycasting.html
1. https://www.youtube.com/watch?v=NbSee-XM7WA
1. https://www.youtube.com/watch?v=gYRrGTC7GtA
