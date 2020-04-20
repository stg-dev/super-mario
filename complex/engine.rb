require 'ruby2d'
require './complex/classes/scene'
require './complex/classes/player'
# require './code.rb'

# Variables
@actions = [] # all actions to perform

set title: 'Super Mario'
set background: 'blue'
set width: 1066
set height: 600
set resizable: false

player = Player.new(200, 200)
scene = Scene.new(player)

on :key_down do |event|
  if event.key == 'w' || event.key == 'space'
    player.jump(5)
  end

  if event.key == 'd'
    player.move('right')
  end

  if event.key == 'a'
    player.move('left')
  end
end

on :key_up do |event|
  unless event.key == 'w' || event.key == 'space'
    player.move(nil)
  end
end

update do
  scene.simulate_physics
  scene.animate
end

show