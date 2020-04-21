require 'ruby2d'
require './complex/classes/scene'
require './complex/classes/player'
require './complex/classes/block'
require './complex/classes/cloud'
# require './code.rb'

# Variables
@actions = [] # all actions to perform

set title: 'Super Mario'
set background: 'blue'
set width: 1066
set height: 600
set resizable: false

player = Player.new(200, 400)
scene = Scene.new(player)
scene.add_to_scene(Block.new(50, 500).append_blocks(30))
scene.add_to_scene(Block.new(0, 550).append_blocks(30))

scene.add_to_scene(Block.new(500, 400))
scene.add_to_scene(Block.new(500, 450))
scene.add_to_scene(Block.new(600, 350))

scene.add_to_scene(Cloud.new(1200))

on :key_down do |event|
  player.jump(7) if event.key == 'w' || event.key == 'space'

  player.move('right') if event.key == 'd'

  player.move('left') if event.key == 'a'
end

on :key_up do |event|
  player.move(nil) unless event.key == 'w' || event.key == 'space'
end

update do
  scene.simulate_physics
  scene.animate
end

show
