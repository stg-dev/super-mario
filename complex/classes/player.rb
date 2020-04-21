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
    @y_speed = -speed if @collisions["bottom"]
  end

  def animate
    move_entity unless @movement == nil

    @x_speed = 0 if @collisions["left"] && @x_speed < 0
    @x_speed = 0 if @collisions["right"] && @x_speed > 0
    @y_speed = 0 if @collisions["top"] && @y_speed < 0
    @y_speed = 0 if @collisions["bottom"] && @y_speed > 0

    if @x_speed < 0 && !@collisions["left"]
      set_cords(@x_pos + @x_speed, nil)
      @x_speed += 0.25
    end

    if @x_speed > 0 && !@collisions["right"]
      set_cords(@x_pos + @x_speed, nil)
      @x_speed -= 0.25
    end

    set_cords(nil, @y_pos + @y_speed) if @y_speed < 0 && !@collisions["top"]

    set_cords(nil, @y_pos + @y_speed) if @y_speed > 0 && !@collisions["bottom"]

    update_square
  end

  def update_square
    if @image.x != @x_pos || @image.y != @y_pos
      @image.x = @x_pos
      @image.y = @y_pos
    end
  end
end