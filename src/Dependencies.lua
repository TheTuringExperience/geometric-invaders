-- Technical depencies
Class = require 'lib/class'
push = require 'lib/push'

-- Game States Utils
require "src/StateMachine"
require "src/states/BaseState"

-- Actual Game states
require "src/states/StartState"
require "src/states/PlayState"
require "src/states/GameOver"

-- Game Objects
require "src/Tank"
require "src/Bullet"
require "src/Alien"
require "src/AlienSquad"

-- Constants and System variables
require "src/constants"