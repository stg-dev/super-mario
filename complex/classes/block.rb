require './complex/classes/parents/collison_object'

class Block < CollisionObject
  def initialize(x_pos, y_pos)
    super(x_pos, y_pos, 30, 30, false, false)
    puts "block erstellt"

    place_block
  end

  def place_block
    @background = Image.new(
        'assets/block.bmp',
        x: @x_pos, y: @y_pos,
        width: @width,
        height: @height,
        z: 2
    )
  end

  def append_blocks(number)
    appended_blocks = []

    i = 1
    until i > number
      appended_blocks.append(Block.new(@x_pos + @width * i, @y_pos))
      i += 1
    end

    appended_blocks
  end
end