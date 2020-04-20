require './complex/classes/collision_detector'

class Scene
  attr_reader :elements

  def initialize(player)
    @background = Image.new(
      'assets/background.bmp',
      x: 0, y: 0,
      width: 8960,
      height: 600,
      z: 1
    )

    @elements = [player]

    @collision_detector = CollisionDetector.new
  end

  def simulate_physics
    @collision_detector.detect_collisions(@elements)

    @elements.each do |element|
      next unless element.simulate_physics

      element.y_speed += 0.2
    end
  end

  def animate
    @elements.each(&:animate)
  end
end