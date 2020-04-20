require './complex/classes/parents/collison_object'

class LivingEntity < CollisionObject
  attr_accessor :alive

  def initialize(x_pos, y_pos, width, height, simulate_physics, is_animated)
      super(x_pos, y_pos, width, height, simulate_physics, is_animated)
  end
end