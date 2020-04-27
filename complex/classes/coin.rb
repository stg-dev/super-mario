require './complex/classes/collision_detector'
class Coin < CollisionObject

  def initialize(x_pos, y_pos)
    super(x_pos, y_pos, 50, 50, false, false)
    place_coin
  end

  def place_coin
    @image = Image.new(
        'assets/coin.png',
        x: @x_pos, y: @y_pos,
        width: @width,
        height: @height,
        z: 2
    )
  end

  def remove
    @image.y = -200
  end
end