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
  def detect_collisions(entity, elements)
    entity.collisions.each do |key, _|
      entity.collisions[key] = false
    end

    overlay(entity.collisions, check_window(entity, 1066, 600))

    elements.each do |element|
      overlay(entity.collisions, check_collision(entity, element))
    end

    # puts("all: " + entity.collisions.to_s)
  end

  def check_collision(element1, element2)
    collisions = {}

    dtop = element1.y_pos - (element2.y_pos + element2.height)
    dbottom = element2.y_pos - (element1.y_pos + element1.height)
    dleft = element1.x_pos - (element2.x_pos + element2.width)
    dright = element2.x_pos - (element1.x_pos + element1.width)

    # puts({"dtop"=> dtop, "dbottom" => dbottom, "dleft" => dleft, "dright" => dright})

    collisions["top"] = dtop <= 0 && dtop > -element2.height
    collisions["bottom"] = dbottom <= 0 && dbottom > -element2.height
    collisions["right"] = dright <= 0 && dright > element2.width
    collisions["left"] =dleft <= 0 && dleft > element2.width
    # puts("e2e: " + collisions.to_s)
    collisions
  end

  def check_window(entity, width, height)
    collisions = {}

    collisions["top"] = entity.y_pos <= 0
    collisions["bottom"] = entity.y_pos + entity.height >= height
    collisions["left"] = entity.x_pos <= 0
    collisions["right"] = entity.x_pos + entity.width >= width
    # puts("w2e: " + collisions.to_s)
    collisions
  end

  def overlay(map1, map2)
    map2.each do |key, val|
      map1[key] = true if val
    end
  end
end