require './complex/classes/parents/living_entity'
require './complex/classes/parents/passive_object'

class CollisionDetector
  def detect_collisions(elements)
    elements.each do |element|
      next unless element.is_a?(LivingEntity)
      # collisions with window border
      element.collisions = {
          'left' => element.x_pos < 0,
          'right' => element.x_pos + element.width > 1066,
          'top' => element.y_pos < 0,
          'bottom' => element.y_pos + element.height > 600
      }

      center_of_entity = { 'x' => element.x_pos + element.width / 2, 'y' => element.y_pos + element.height / 2 }

      elements.each do |other_element|
        next if element == other_element || other_element.kind_of?(PassiveObject)

        center_of_other_element = {'x' => other_element.x_pos + other_element.width / 2, 'y' => other_element.y_pos + other_element.height / 2 }

        distance = Math.sqrt(((center_of_entity["x"] - center_of_other_element["x"])**2 + (center_of_entity["y"] - center_of_other_element["y"])**2))

        next if distance > 150

        element.collisions = {
            "right" => !element.collisions["right"] ? (element.x_pos + element.width > other_element.x_pos && element.x_pos - 5 < other_element.x_pos + other_element.width) && ((element.y_pos > other_element.y_pos && element.y_pos < other_element.y_pos + other_element.height) || (element.y_pos + element.height < other_element.y_pos + other_element.height && element.y_pos + element.height > other_element.y_pos)) : true,
            "left" => !element.collisions["left"] ? (element.x_pos > other_element.x_pos && element.x_pos < other_element.x_pos + other_element.width) && ((element.y_pos > other_element.y_pos && element.y_pos < other_element.y_pos + other_element.height) || (element.y_pos + element.height < other_element.y_pos + other_element.height && element.y_pos + element.height > other_element.y_pos)) : true,
            "bottom" => !element.collisions["bottom"] ? element.y_pos + element.height + 5 >= other_element.y_pos && element.y_pos + element.height < other_element.y_pos + other_element.height && ((element.x_pos > other_element.x_pos && element.x_pos < other_element.x_pos + other_element.width) || (element.x_pos + element.width < other_element.x_pos + other_element.width && element.x_pos + element.width > other_element.x_pos)) : true,
            "top" => !element.collisions["top"] ? element.y_pos - 5 <= other_element.y_pos + other_element.height && element.y_pos > other_element.y_pos && ((element.x_pos > other_element.x_pos && element.x_pos < other_element.x_pos + other_element.width) || (element.x_pos + element.width < other_element.x_pos + other_element.width && element.x_pos + element.width > other_element.x_pos)) : true
        }
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

    collisions['top'] = dtop <= 0 && dtop > -element2.height if y_in_range
    collisions['bottom'] = dbottom <= 0 && dtop > -element2.height if y_in_range
    collisions['right'] = dright <= 0 && dright > -element2.width if x_in_range
    collisions['left'] = dleft <= 0 && dleft > -element2.width if x_in_range

    collisions
  end

  def test_collision(e1, e2)
    y_not_range = e1.y_pos > e2.y_pos + e2.height || e1.y_pos + e1.height < e2.y_pos
    x_not_range = e1.x_pos > e2.x_pos + e2.width || e1.x_pos + e1.width < e2.x_pos

    dx = e2.x_pos - e1.x_pos
    dy = e2.y_pos - e1.y_pos

    unless y_not_range
      return 'right' if dx >= 0
      return 'left' if dx <= e1.width
    end

    unless x_not_range
      return 'bottom' if dy >= 0
      return 'top' if dy <= e1.height
    end

    ''
  end

  def check_window(entity, width, height)
    collisions = {}

    collisions['top'] = entity.y_pos <= 0
    collisions['bottom'] = entity.y_pos + entity.height >= height
    collisions['left'] = entity.x_pos <= 0
    collisions['right'] = entity.x_pos + entity.width >= width
    collisions
  end

  def overlay(map1, map2)
    map2.each do |key, val|
      map1[key] = true if val
    end
  end
end
