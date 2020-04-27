require 'ruby2d'
require './complex/classes/scene'
require './complex/classes/player'
require './complex/classes/block'
require './complex/classes/cloud'
require './complex/classes/text_output'
require './complex/classes/coin'

# Variables
set title: 'Super Mario'
set background: 'blue'
set width: 1066
set height: 600
set resizable: false

# Gestalte hier deine Scene

player = Player.new(120, 300)
scene = Scene.new(player)
scene.add_to_scene(Block.new(0, 500).append_blocks(400))
scene.add_to_scene(Block.new(0, 550).append_blocks(400))
scene.add_to_scene(Coin.new(350, 350))

# Ende der Gestalltung

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
