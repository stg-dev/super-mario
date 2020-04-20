require './complex/classes/parents/living_entity'

class CollisionDetector
  def detect_collisions(elements)
    new_elements = []
    elements.each do |element|
      new_elements.append(element) if element.is_a?(LivingEntity)
    end

    new_elements.each do |element|
      # Check Border of view
      if element.x_pos < 0
        element.collisions['left'] = true
      elsif element.x_pos > 0 && element.collisions['left']
        element.collisions['left'] = false
      end

      if element.x_pos + element.width > 1066
        element.collisions['right'] = true
      elsif element.x_pos + element.width < 1066 && element.collisions['right']
        element.collisions['right'] = false
      end

      if element.y_pos < 0
        element.collisions['top'] = true
      elsif element.y_pos > 0 && element.collisions['top']
        element.collisions['top'] = false
      end

      if element.y_pos + element.height > 600
        element.collisions['bottom'] = true
      elsif element.y_pos + element.height < 600 && element.collisions['bottom']
        element.collisions['bottom'] = false
      end

      elements.each do |other_element|
        next if element == other_element
      end
    end
  end
end
