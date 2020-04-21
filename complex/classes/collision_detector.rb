# Working! Includes improved Math and Logic
class BenniCollisionDetector
  def detect_collisions(elements)
    elements.each do |entity|
      next unless entity.is_a? LivingEntity
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
  end

  def check_intersection(e1, e2)
    if e1.x1 <= e2.x2 && e1.x2 >= e2.x1 && e1.y1 <= e2.y2 && e1.y2 >= e2.y1
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
