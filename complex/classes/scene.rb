require './complex/classes/collision_detector'
require './complex/classes/block'

class Scene
  attr_reader :elements

  def initialize(player)
    @elements = [player]

    @collision_detector = CollisionDetector.new
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
    @collision_detector.detect_collisions(@elements)

    @elements.each do |element|
      if element.simulate_physics && !element.collisions["bottom"]
        element.y_speed += 0.2
      end
    end
  end

  def animate
    if @elements[0].x_pos > 800
      @elements.each do |element|
        element.x_pos -= 5
      end
    end

    @elements.each do |element|
      next unless element.is_animated

      element.animate
    end
  end
end