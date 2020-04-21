# Defines a Object which has Collision
class CollisionObject
  attr_accessor :collisions, :x_pos, :y_pos, :width, :height, :x1, :x2, :y1, :y2, :simulate_physics, :is_animated

  def initialize(x_pos, y_pos, width, height, simulate_physics, is_animated)
    @collisions = {'top' => false, 'left' => false, 'bottom' => false, 'right' => false}

    @width = width
    @height = height
    @simulate_physics = simulate_physics
    @is_animated = is_animated

    set_cords(x_pos, y_pos)
  end

  def set_cords(x_pos, y_pos)
    unless x_pos.nil?
      @x_pos = x_pos

      @x1 = x_pos
      @x2 = x_pos + @width
    end

    unless y_pos.nil?
      @y_pos = y_pos

      @y1 = y_pos
      @y2 = y_pos + @height
    end
    nil
  end
end
