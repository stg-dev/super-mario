class PassiveObject
  attr_accessor :x_pos, :y_pos, :x_movement, :y_movement, :image, :simulate_physics, :is_animated

  def initialize(x_pos, y_pos, x_movement, y_movement, image)
    @x_pos = x_pos
    @y_pos = y_pos
    @x_movement = x_movement
    @y_movement = y_movement
    @image = image
    @simulate_physics = false
    @is_animated = true
  end

  def animate
    @image.x = @x_pos + x_movement
    @image.y = @y_pos + y_movement
  end
end