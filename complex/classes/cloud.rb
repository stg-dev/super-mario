require './complex/classes/parents/passive_object'

class Cloud < PassiveObject
  def initialize(x_pos)
    super(x_pos, y)
  end
end