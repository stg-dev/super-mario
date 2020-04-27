require './complex/classes/parents/passive_object'
class TextOutput < PassiveObject
  attr_accessor :text, :x_pos, :_pos

  def initialize(x_pos, y_pos, text)
    @text = text
    @x_pos = x_pos
    @y_pos = y_pos

    @text = Text.new(
        @text,
        font: './assets/font.ttf',
        x: @x_pos, y: @y_pos,
        size: 20,
        color: 'white',
        z: 10
    )
  end

  def update(text)
    @text.text = text
  end
end