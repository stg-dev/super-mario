require './complex/classes/parents/collison_object'

class Player < CollisionObject
  attr_reader :x_speed
  attr_accessor :y_speed

  def initialize(x_pos, y_pos)
    super(x_pos, y_pos, 20, 20, true, true)

    @x_speed = 0
    @y_speed = 0

    @movement = nil

    @square = Square.new(
      x: @x_pos, y: @y_pos,
      size: @width,
      color: 'green',
      z: 2
    )
  end

  def move(direction)
    @movement = direction
  end

  def move_entity
    if @movement == "right"
      @x_speed = @x_speed < 7 ? @x_speed + 1 : @x_speed
    elsif @movement == "left"
      @x_speed = @x_speed > -7 ? @x_speed - 1 : @x_speed
    end
  end

  def jump(speed)
    @y_speed = -speed
  end

  def animate
    unless @movement == nil
      move_entity
    end

    if @x_speed < 0 && !@collisions["left"]
      @x_pos += @x_speed
      @x_speed += 0.5
    end

    if @x_speed > 0 && !@collisions["right"]
      @x_pos += @x_speed
      @x_speed -= 0.5
    end

    if @y_speed < 0 && !@collisions["top"]
      @y_pos += @y_speed
    end

    if @y_speed > 0 && !@collisions["bottom"]
      @y_pos += @y_speed
    end

    update_square
  end

  def update_square
    if @square.x != @x_pos || @square.y != @y_pos
      @square.x = @x_pos
      @square.y = @y_pos
    end
  end
end