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
        overlay(entity.collisions, { check_intersection(entity, element) => true })
      end
    end

    # puts(entity.collisions)
  end

  def check_intersection(e1, e2)
    if e1.x1 < e2.x2 && e1.x2 > e2.x1 && e1.y1 < e2.y2 && e1.y2 > e2.y1
      dx = (e2.x_pos + e2.width / 2) - (e1.x_pos + e1.width / 2)
      dy = (e2.y_pos + e2.height / 2) - (e1.y_pos + e1.height / 2)

      return 'bottom' if dy > dx && dy > 0
      return 'top' if dy > dx && dy < 0
      return 'right' if dy < dx && dx > 0
      return 'left' if dy < dx && dy < 0

      return nil
    end
    nil
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
