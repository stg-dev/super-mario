class CollisionObject
  attr_accessor :collisions

  def initialize
    @collisions = {
        "top" => false,
        "left" => false,
        "bottom" => false,
        "right" => false
    }
  end
end