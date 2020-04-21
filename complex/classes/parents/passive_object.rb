class PassiveObject
  attr_accessor :x_pos, :y_pos, :x_movement, :y_movement, :image, :simulate_physics, :is_animated

  def initialize(x_pos, y_pos, x_movement, y_movement, image)
    @x_movement = x_movement
    @y_movement = y_movement
    @image = image
    @simulate_physics = false
    @is_animated = true

    set_cords(x_pos, y_pos)
  end

  def set_cords(x_pos, y_pos)
    @x_pos = x_pos unless x_pos.nil?
    @y_pos = y_pos unless y_pos.nil?
    nil
  end

  def animate
    @image.x = @x_pos + x_movement
    @image.y = @y_pos + y_movement
  end
end