
require("langUtils.tableUtils")
require("langUtils.mathUtils")
require("langUtils.stringUtils")

local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")

local controller = require("scenes.game.gameController")
local viewSpecs = require("scenes.game.view.viewSpecs")
local boardView = require("scenes.game.view.boardView")
local primarySceneGroup = nil
local boardSceneGroup = display.newGroup()
local board = nil



scene.drawBoard = function(boardModel)
  index = 1
  for rowKey, row in pairs(board) do
    for tileKey, tile in pairs(row) do
      tile.x = viewSpecs.boardViewSpecs.tileSpecs.x(index)
      tile.y = viewSpecs.boardViewSpecs.tileSpecs.y(index)
      tile:setFrame(string.letterToNumber(boardModel[rowKey][tileKey]))
      index = index + 1
    end
  end
end

scene.updateBoardSprites = function(boardModel)
  for rowKey, row in pairs(board) do
    for tileKey, tile in pairs(row) do
      tile:setFrame(letterToNumber(boardModel[rowKey][tileKey]))
    end
  end
end

scene.refreshBoard = function(event)
  controller.refreshBoard(scene)
end

local tileTouched = function(event)
  controller.processTileTouch(event.coordinates, scene)
end

function setUpTileListeners()
  local touched = function(event)
    if event.phase == "ended" then
      boardSceneGroup:dispatchEvent({name= "tileTouched", coordinates = event.target.coordinates})
    end
  end
  for rowKey, row in pairs(board) do
    for tileKey, tile in pairs(row) do
      tile:addEventListener("touch", touched)
    end
  end
end

scene.createBoard = function(boardModel)
  board = boardView(boardSceneGroup)
  setUpTileListeners()
  scene.drawBoard(boardModel)
end


function scene:create( event )
  composer.removeHidden()
  primarySceneGroup = self.view
  primarySceneGroup:insert(boardSceneGroup)
  boardSceneGroup.y = display.contentHeight / 3
  controller.controlScene(scene, event.params.difficulty, event.params.characters)
end

function scene:destroy( event )
end

boardSceneGroup:addEventListener( "tileTouched", tileTouched)
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
