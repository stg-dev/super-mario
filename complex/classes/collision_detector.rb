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
end

class BenniCollisionDetector
  def detect_collisions(elements)
    i = 1
    e = elements[0]
    while i < elements.length
      check_collision(e, elements[i]).collisions.each_key do |key, val|
        if val && (e.collisions[key] == false)
          e.collisions[key] = true
        end
      end
      i += 1
    end
  end

  def check_collision(e1, e2)
    dtop = e1.y_pos - e2.y_pos + e2.height
    dbottom = e1.y_pos + e1.height - e2.y_pos
    dleft = e1.x_pos - e2.x_pos + e2.width
    dright = e1.x_pos + e1.width - e2.x_pos
    # jhk
    e1.collisions["top"] = dtop < 0 && dtop <= -(e2.height)
    e1.collisions["bottom"] = dbottom < 0 && dbottom <= -(e2.height)
    e1.collisions["right"] = dright < 0 && dright <= -(e2.width)
    e1.collisions["left"] = dleft < 0 && dleft <= -(e2.width)
    e1
  end
end