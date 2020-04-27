require './complex/classes/collision_detector'
require './complex/classes/block'
require './complex/classes/text_output'

class Scene
  attr_reader :elements

  def initialize(player)
    @elements = [player]
    @score = 0
    @score_text = TextOutput.new(20,20, ("PUNKTE: " + @score.to_s))

    @collision_detector = CollisionDetector.new

    @add_to_score = -> { @score += 1 }
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
    @collision_detector.detect_collisions(@elements, @add_to_score)

    @elements.each do |element|
      if element.simulate_physics && !element.collisions["bottom"]
        element.y_speed += 0.2
      end
    end
  end

  def animate
    if @elements[0].x_pos > 800
      @elements.each do |element|
        element.set_cords(element.x_pos - 5, nil)
      end
    end

    @elements.each do |element|
      next unless element.is_animated

      element.animate
    end

    @score_text.update(("PUNKTE: " + @score.to_s))
  end
end
