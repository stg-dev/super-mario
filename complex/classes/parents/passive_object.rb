class PassiveObject
  attr_accessor :x_pos, :y_pos, :x_movement, :y_movement

  def initialize(x_pos, y_pos, x_movement, y_movement)
    @x_pos = x_pos
    @y_pos = y_pos
    @x_movement = x_movement
    @y_movement = y_movement
  end
end