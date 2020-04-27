require './complex/classes/parents/living_entity'
require './complex/classes/parents/passive_object'
require './complex/classes/coin'

# Winklers version: DONT USE! Unoptimized and buggy!
class CollisionDetector
  def detect_collisions(elements, score)
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
        next if element == other_element || other_element.is_a?(PassiveObject)

        center_of_other_element = {'x' => other_element.x_pos + other_element.width / 2, 'y' => other_element.y_pos + other_element.height / 2 }

        distance = Math.sqrt(((center_of_entity['x'] - center_of_other_element['x'])**2 + (center_of_entity['y'] - center_of_other_element['y'])**2))

        next if distance > 150

        element.collisions = {
          'right' => !element.collisions['right'] ? (element.x_pos + element.width > other_element.x_pos && element.x_pos - 5 < other_element.x_pos + other_element.width) && ((element.y_pos > other_element.y_pos && element.y_pos < other_element.y_pos + other_element.height) || (element.y_pos + element.height < other_element.y_pos + other_element.height && element.y_pos + element.height > other_element.y_pos)) : true,
          'left' => !element.collisions['left'] ? (element.x_pos > other_element.x_pos && element.x_pos < other_element.x_pos + other_element.width) && ((element.y_pos > other_element.y_pos && element.y_pos < other_element.y_pos + other_element.height) || (element.y_pos + element.height < other_element.y_pos + other_element.height && element.y_pos + element.height > other_element.y_pos)) : true,
          'bottom' => !element.collisions['bottom'] ? element.y_pos + element.height + 10 >= other_element.y_pos && element.y_pos + element.height < other_element.y_pos + other_element.height && ((element.x_pos > other_element.x_pos && element.x_pos < other_element.x_pos + other_element.width) || (element.x_pos + element.width < other_element.x_pos + other_element.width && element.x_pos + element.width > other_element.x_pos)) : true,
          'top' => !element.collisions['top'] ? element.y_pos - 5 <= other_element.y_pos + other_element.height && element.y_pos > other_element.y_pos && ((element.x_pos > other_element.x_pos && element.x_pos < other_element.x_pos + other_element.width) || (element.x_pos + element.width < other_element.x_pos + other_element.width && element.x_pos + element.width > other_element.x_pos)) : true
        }

        if element.collisions['right'] || element.collisions['left'] || element.collisions['top'] || element.collisions['bottom']
          if other_element.kind_of?(Coin)
            other_element.remove
            elements.delete(other_element)
            score.call
          end
        end
      end
    end
  end
end

# Better and optimizied CollisionDetector! Made by Benni
class BetterCollisionDetector
  def detect_collisions(elements)
    safe = 10

    elements.each do |entity|
      next unless entity.is_a? LivingEntity

      entity.collisions = {
        'top' => entity.y1 <= 0,
        'bottom' => entity.y2 >= 600,
        'left' => entity.x1 <= 0,
        'right' => entity.x2 >= 1066
      }

      elements.each do |element|
        next unless element.is_a? CollisionObject
        next unless entity.x1 - safe < element.x2 && entity.x2 + safe > element.x1 && entity.y1 - safe < element.y2 && entity.y2 + safe > element.y1

        check_x = (entity.x1 > element.x1 && entity.x1 < element.x2) || (entity.x2 < element.x2 && entity.x2 > element.x1)
        check_y = (entity.y1 > element.y2 && entity.y1 < element.y1) || (entity.y2 < element.y2 && entity.y2 > element.y1)

        entity.collisions['right'] = entity.x2 + safe > element.x1 && entity.x1 + safe < element.x2 && check_y unless entity.collisions['right']
        entity.collisions['left'] = entity.x1 - safe > element.x1 && entity.x1 - safe < element.x2 && check_y unless entity.collisions['left']
        entity.collisions['bottom'] = entity.y2 + safe >= element.y1 && entity.y2 + safe < element.y2 && check_x unless entity.collisions['bottom']
        entity.collisions['top'] = entity.y1 - safe <= element.y2 && entity.y1 - safe> element.y1 && check_x unless entity.collisions['top']
      end
    end
  end
end

# DEPRACTED: Please use BetterCollisionDetector
class BenniCollisionDetector
  def detect_collisions(elements)
    throw "DEPRACTED! Please use BetterCollisionDetector"
  end

  # def detect_collisions(elements)
  #   elements.each do |entity|
  #     next unless entity.is_a? LivingEntity
  #
  #     entity.collisions.each do |key, _|
  #       entity.collisions[key] = false
  #     end
  #
  #     overlay(entity.collisions, check_window(entity, 1066, 600))
  #
  #     elements.each do |element|
  #       # overlay(entity.collisions, { check_intersection(entity, element) => true }) if element.is_a? CollisionObject
  #       overlay(entity.collisions, check_collision(entity, element)) if element.is_a? CollisionObject
  #     end
  #   end
  # end
  #
  # def check_collision(e1, e2)
  #   collisions = {}
  #   if e1.x1 - 10 < e2.x2 && e1.x2 + 10 > e2.x1 && e1.y1 - 10 < e2.y2 && e1.y2 + 10 > e2.y1
  #     # puts('inters')
  #     check_x = ((e1.x1 > e2.x1 && e1.x1 < e2.x2) || (e1.x2 < e2.x2 && e1.x2 > e2.x1))
  #     check_y = ((e1.y1 > e2.y2 && e1.y1 < e2.y1) || (e1.y2 < e2.y2 && e1.y2 > e2.y1))
  #
  #     collisions = {
  #       'right' => e1.x2 + 10 > e2.x1 && e1.x1 + 10 < e2.x2 && check_y,
  #       'left' => e1.x1 - 10 > e2.x1 && e1.x1 - 10 < e2.x2 && check_y,
  #       'bottom' => e1.y2 + 10 >= e2.y1 && e1.y2 + 10 < e2.y2 && check_x,
  #       'top' => e1.y1 - 10 <= e2.y2 && e1.y1 - 10> e2.y1 && check_x
  #     }
  #   end
  #   collisions
  # end
  #
  # def check_window(entity, width, height)
  #   collisions = {}
  #
  #   collisions['top'] = entity.y_pos <= 0
  #   collisions['bottom'] = entity.y_pos + entity.height >= height
  #   collisions['left'] = entity.x_pos <= 0
  #   collisions['right'] = entity.x_pos + entity.width >= width
  #   collisions
  # end
  #
  # def overlay(map1, map2)
  #   map2.each do |key, val|
  #     map1[key] = true if val
  #   end
  # end
end
