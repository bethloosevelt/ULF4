
require("langUtils.tableUtils")
require("langUtils.mathUtils")

local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")

local controller = require("scenes.game.gameController")
local viewSpecs = require("scenes.game.view.viewSpecs")
local boardView = require("scenes.game.view.boardView")
local primarySceneGroup = nil
local board = nil


function removeBoard()
  for key, row in board do
    for key, tile in row do
      if tile then
        tile:removeSelf()
      end
    end
  end
end

function drawBoard()
  index = 1
  for rowKey, row in pairs(board) do
    for tileKey, tile in pairs(row) do
      tile.x = viewSpecs.boardViewSpecs.tileSpecs.x(index)
      tile.y = viewSpecs.boardViewSpecs.tileSpecs.y(index)
      primarySceneGroup:insert(tile)
      index = index + 1
    end
  end
end

function scene:replaceBoard( boardModel )
  if board then
    removeBoard()
  end

  board = boardView(boardModel)
  drawBoard()
end


function scene:create( event )
  composer.removeHidden( )
  primarySceneGroup = self.view
  controller.controlScene(scene, event.params.difficulty, event.params.characters)
end

function scene:destroy( event )
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
