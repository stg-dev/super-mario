require './complex/classes/collision_detector'
require './complex/classes/block'

class Scene
  attr_reader :elements

  def initialize(player)
    @elements = [player]

    @collision_detector = BenniCollisionDetector.new
  end

  def add_to_scene(element)
    if element.kind_of?(Array)
      @elements.concat element
      @elements + element
    else
      @elements.append(element)
    end
  end

  def simulate_physics
    copy = @elements
    copy.pop(0)
    @collision_detector.detect_collisions(@elements[0], copy)

    @elements.each do |element|
      next unless element.simulate_physics

      element.y_speed += 0.2
    end
  end

  def animate
    @elements.each do |element|
      next unless element.is_animated
      element.animate
    end
  end
end