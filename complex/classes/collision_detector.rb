# DEPRECATED: only implements window collisions
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

# Working! Includes improved Math and Logic
class BenniCollisionDetector
  def detect_collisions(entity, elements)
    entity.collisions.each do |key, _|
      entity.collisions[key] = false
    end

    overlay(entity.collisions, check_window(entity, 1066, 600))

    elements.each do |element|
      if element.is_a? CollisionObject
        overlay(entity.collisions, check_collision(entity, element))
        # overlay(entity.collisions, {test_collision(entity, element) => true})
      end
    end

    puts(entity.collisions)
  end

  def check_collision(element1, element2)
    collisions = {}

    dtop = element1.y_pos - (element2.y_pos + element2.height)
    dbottom = element2.y_pos - (element1.y_pos + element1.height)
    dleft = element1.x_pos - (element2.x_pos + element2.width)
    dright = element2.x_pos - (element1.x_pos + element1.width)

    # puts({"dtop"=> dtop, "dbottom" => dbottom, "dleft" => dleft, "dright" => dright})

    y_in_range = element1.y_pos <= element2.y_pos + element2.height && element1.y_pos + element1.height >= element2.y_pos
    x_in_range = element1.x_pos <= element2.x_pos + element2.width && element1.x_pos + element1.width >= element2.x_pos

    collisions["top"] = dtop <= 0 && dtop > -element2.height if y_in_range
    collisions["bottom"] = dbottom <= 0 && dtop > -element2.height if y_in_range
    collisions["right"] = dright <= 0 && dright > -element2.width if x_in_range
    collisions["left"] = dleft <= 0 && dleft > -element2.width if x_in_range

    collisions
  end

  def test_collision(e1, e2)
    y_not_range = e1.y_pos > e2.y_pos + e2.height || e1.y_pos + e1.height < e2.y_pos
    x_not_range = e1.x_pos > e2.x_pos + e2.width || e1.x_pos + e1.width < e2.x_pos

    dx = e2.x_pos - e1.x_pos
    dy = e2.y_pos - e1.y_pos

    unless y_not_range
      return "right" if dx >= 0
      return "left" if dx <= e1.width
    end

    unless x_not_range
      return "bottom" if dy >= 0
      return "top" if dy <= e1.height
    end

    ""
  end

  def check_window(entity, width, height)
    collisions = {}

    collisions["top"] = entity.y_pos <= 0
    collisions["bottom"] = entity.y_pos + entity.height >= height
    collisions["left"] = entity.x_pos <= 0
    collisions["right"] = entity.x_pos + entity.width >= width
    collisions
  end

  def overlay(map1, map2)
    map2.each do |key, val|
      map1[key] = true if val
    end
  end
end
