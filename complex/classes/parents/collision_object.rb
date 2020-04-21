# Defines a Object which has Collision
class CollisionObject
  attr_accessor :collisions, :x_pos, :y_pos, :width, :height, :simulate_physics, :is_animated

  def initialize(x_pos, y_pos, width, height, simulate_physics, is_animated)
    @collisions = {"top" => false, "left" => false, "bottom" => false, "right" => false}

    @x_pos = x_pos
    @y_pos = y_pos
    @width = width
    @height = height
    @simulate_physics = simulate_physics
    @is_animated = is_animated
  end

  def x1
    x_pos
  end

  def x2
    x_pos + width
  end

  def y1
    y_pos
  end

  def y2
    y_pos + height
  end
end
