import BenchmarkTools as BT
import InteractiveUtils as IU
import RayCaster as RC
import SaferIntegers as SI

IU.versioninfo()
println()

for I in (Int, SI.SafeInt)
    println("#######################################################")
    println("Integer type: $(I)")
    println("#######################################################")
    println()
    height_obstacle_tile_map = I(1024)
    width_obstacle_tile_map = I(1024)
    @show height_obstacle_tile_map
    @show width_obstacle_tile_map

    obstacle_tile_map = falses(height_obstacle_tile_map, width_obstacle_tile_map)

    obstacle_tile_map[:, begin] .= true
    obstacle_tile_map[:, end] .= true
    obstacle_tile_map[begin, :] .= true
    obstacle_tile_map[end, :] .= true

    tile_length = I(256)
    @show tile_length

    x_ray_start = (height_obstacle_tile_map * tile_length) ÷ I(2) + I(1)
    y_ray_start = (width_obstacle_tile_map * tile_length) ÷ I(2) + I(1)
    @show x_ray_start
    @show y_ray_start

    x_ray_direction = I(3)
    y_ray_direction = I(1)
    @show x_ray_direction
    @show y_ray_direction

    max_steps = I(1024)
    @show max_steps

    num_rays = I(1024)
    @show num_rays

    ray_cast_outputs = Vector{NTuple{9, I}}(undef, num_rays)

    semi_field_of_view_ratio = I(2)//I(1)
    @show semi_field_of_view_ratio

    x_camera_normal_direction = x_ray_direction
    y_camera_normal_direction = y_ray_direction
    @show x_camera_normal_direction
    @show y_camera_normal_direction

    # compiling everything once
    BT.@benchmark RC.cast_ray($(Ref(obstacle_tile_map))[], $(Ref(tile_length))[], $(Ref(x_ray_start))[], $(Ref(y_ray_start))[], $(Ref(x_ray_direction))[], $(Ref(y_ray_direction))[], $(Ref(max_steps))[])

    println()
    println("Single ray cast:")
    println()
    display(BT.@benchmark RC.cast_ray($(Ref(obstacle_tile_map))[], $(Ref(tile_length))[], $(Ref(x_ray_start))[], $(Ref(y_ray_start))[], $(Ref(x_ray_direction))[], $(Ref(y_ray_direction))[], $(Ref(max_steps))[]))
    println()

    # compiling everything once
    BT.@benchmark RC.cast_rays!($(Ref(ray_cast_outputs))[], $(Ref(obstacle_tile_map))[], $(Ref(tile_length))[], $(Ref(x_ray_start))[], $(Ref(y_ray_start))[], $(Ref(x_camera_normal_direction))[], $(Ref(y_camera_normal_direction))[], $(Ref(semi_field_of_view_ratio))[], $(Ref(max_steps))[])

    println()
    println("Multiple ray cast:")
    println()
    display(BT.@benchmark RC.cast_rays!($(Ref(ray_cast_outputs))[], $(Ref(obstacle_tile_map))[], $(Ref(tile_length))[], $(Ref(x_ray_start))[], $(Ref(y_ray_start))[], $(Ref(x_camera_normal_direction))[], $(Ref(y_camera_normal_direction))[], $(Ref(semi_field_of_view_ratio))[], $(Ref(max_steps))[]))
    println()
    println()
end
