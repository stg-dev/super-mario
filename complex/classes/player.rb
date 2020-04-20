require './complex/classes/parents/living_entity'

class Player < LivingEntity
  attr_reader :x_speed
  attr_accessor :y_speed

  def initialize(x_pos, y_pos)
    super(x_pos, y_pos, 40, 80, true, true)

    @x_speed = 0
    @y_speed = 0

    @movement = nil

    @image = Image.new(
        'assets/mario_standing.bmp',
        x: @x_pos, y: @y_pos,
        width: @width,
        height: @height,
        z: 3
    )
  end

  def move(direction)
    @movement = direction
  end

  def move_entity
    if @movement == "right"
      @x_speed = @x_speed < 5 ? @x_speed + 0.5 : @x_speed
    elsif @movement == "left"
      @x_speed = @x_speed > -5 ? @x_speed - 0.5 : @x_speed
    end
  end

  def jump(speed)
    if @collisions["bottom"]
      @y_speed = -speed
    end
  end

  def animate
    unless @movement == nil
      move_entity
    end

    if @x_speed < 0 && !@collisions["left"]
      @x_pos += @x_speed
      @x_speed += 0.25
    end

    if @x_speed > 0 && !@collisions["right"]
      @x_pos += @x_speed
      @x_speed -= 0.25
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
    if @image.x != @x_pos || @image.y != @y_pos
      @image.x = @x_pos
      @image.y = @y_pos
    end
  end
end