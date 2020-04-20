require './complex/classes/parents/collison_object'

class Block < CollisionObject
  def initialize(x_pos, y_pos)
    super(x_pos, y_pos, 50, 50, false, true)
    place_block
  end

  def place_block
    @image = Image.new(
        'assets/block.bmp',
        x: @x_pos, y: @y_pos,
        width: @width,
        height: @height,
        z: 2
    )
  end

  def append_blocks(number)
    appended_blocks = [self]

    i = 1
    until i > number
      appended_blocks.append(Block.new(@x_pos + @width * i, @y_pos))
      i += 1
    end

    appended_blocks
  end

  def animate
    @image.x = @x_pos
    @image.y = @y_pos
  end
end