
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
local boardSceneGroup = display.newGroup()
local actionBarSceneGroup = display.newGroup()
local primarySceneGroup = nil
local board = nil

local CENTER_OF_BOARD_X = display.contentWidth / 2
local TOP_OF_BOARD = display.contentHeight / 3.5
local WIDTH_OF_BOARD = display.contentWidth
local HEIGHT_OF_BOARD = display.contentWidth

local HEIGHT_OF_ACTION_BAR = display.contentHeight - TOP_OF_BOARD - HEIGHT_OF_BOARD
local WIDTH_OF_ACTION_BAR = display.contentWidth
local CENTER_OF_ACTION_BAR_X = display.contentWidth / 2
local TOP_OF_ACTION_BAR = TOP_OF_BOARD + HEIGHT_OF_BOARD


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
      if event.target.frame <= 26 then
        event.target:setFrame(event.target.frame + 26)
      end
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

function initBackgrounds()
  local boardBackground = display.newRect( boardSceneGroup, CENTER_OF_BOARD_X, display.contentWidth / 2, WIDTH_OF_BOARD, HEIGHT_OF_BOARD )
  boardBackground:setStrokeColor( 1, 1, 1 )
  local actionBarBackground = display.newRect( actionBarSceneGroup, CENTER_OF_ACTION_BAR_X, HEIGHT_OF_ACTION_BAR / 2, display.contentWidth, HEIGHT_OF_ACTION_BAR )
  actionBarBackground:setStrokeColor( 1, .2, .2 )
end

function scene:create( event )
  composer.removeHidden()
  primarySceneGroup = self.view
  primarySceneGroup:insert(boardSceneGroup)
  primarySceneGroup:insert(actionBarSceneGroup)
  boardSceneGroup.y = TOP_OF_BOARD
  actionBarSceneGroup.y = TOP_OF_ACTION_BAR
  initBackgrounds()
  controller.controlScene(scene, event.params.difficulty, event.params.characters)
end

function scene:destroy( event )
end

boardSceneGroup:addEventListener( "tileTouched", tileTouched)
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
