class CollisionDetector
  def detect_collisions(elements)
    elements.each do |element|
      # Check Border of view
      if element.x_pos < 0
        element.collisions["left"] = true
      elsif element.x_pos > 0 && element.collisions["left"]
        element.collisions["left"] = false
      end

      if element.x_pos + element.width > 1066
        element.collisions["right"] = true
      elsif element.x_pos + element.width < 1066 && element.collisions["right"]
        element.collisions["right"] = false
      end

      if element.y_pos < 0
        element.collisions["top"] = true
      elsif element.y_pos > 0 && element.collisions["top"]
        element.collisions["top"] = false
      end

      if element.y_pos + element.height > 600
        element.collisions["bottom"] = true
      elsif element.y_pos + element.height < 600 && element.collisions["bottom"]
        element.collisions["bottom"] = false
      end

    end
  end

  def compare()

  end
end