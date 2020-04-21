require './complex/classes/parents/passive_object'

# Defines a Cloud
class Cloud < PassiveObject
  def initialize(x_pos)
    super(x_pos, 20, -5, 0, Image.new(
        'assets/cloud.png',
        x: @x_pos, y: @y_pos,
        width: 80,
        height: 80,
        z: 3
      )
    )
  end
end
