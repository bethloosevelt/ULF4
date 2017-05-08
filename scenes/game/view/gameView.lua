
require("langUtils.tableUtils")
require("langUtils.mathUtils")
require("langUtils.stringUtils")

local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")
local soundEffectsConfig = require("configs.sounds")

local controller = require("scenes.game.gameController")
local viewSpecs = require("scenes.game.view.viewSpecs")
local boardView = require("scenes.game.view.boardView")
local boardDisplayGroup = display.newGroup()
local actionBarDisplayGroup = display.newGroup()
local actionBarDisplayGroup = display.newGroup()

-- Info Bar References
local infoBarDisplayGroup = display.newGroup()
local currentWordLabel = nil

local animationAreaDisplayGroup = display.newGroup()
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


local HEIGHT_OF_INFO_BAR = 100
local WIDTH_OF_INFO_BAR = display.contentWidth
local CENTER_OF_INFO_BAR_X = display.contentWidth / 2
local TOP_OF_INFO_BAR = TOP_OF_BOARD - HEIGHT_OF_INFO_BAR

local HEIGHT_OF_ANIMATION_AREA = TOP_OF_INFO_BAR
local WIDTH_OF_ANIMATION_AREA = display.contentWidth
local CENTER_OF_ANIMATION_AREA_x = display.contentWidth / 2
local TOP_OF_ANIMATION_AREA = 0

local soundEffects = {}

function playTileSound()
  local index = math.random(2)
  audio.play(soundEffects.typewriter[index])
end

function playErrorSound()
  audio.play(soundEffects.error)
end

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

function setUpTileListeners()
  local touched = function(event)
    if event.phase == "ended" then
      if controller.processTileTouch(event.target.coordinates, scene) then
        playTileSound()
        if event.target.frame <= 26 then
          event.target:setFrame(event.target.frame + 26)
        end
      else
        playErrorSound()
      end
    end
  end
  for rowKey, row in pairs(board) do
    for tileKey, tile in pairs(row) do
      tile:addEventListener("touch", touched)
    end
  end
end

scene.createBoard = function(boardModel)
  board = boardView(boardDisplayGroup)
  setUpTileListeners()
  scene.drawBoard(boardModel)
end

function initInfoBar()
  currentWordLabel = display.newText({
    text = "TEST",
    parent = infoBarDisplayGroup,
    x = display.contentWidth / 2,
    y = HEIGHT_OF_INFO_BAR / 2,
    fontSize = HEIGHT_OF_INFO_BAR - 10
  })
end

scene.updateInfoBar = function(wordLabelText)
  currentWordLabel.text = wordLabelText
end

function initBackgrounds()
  local boardBackground = display.newRect( boardDisplayGroup, CENTER_OF_BOARD_X, display.contentWidth / 2, WIDTH_OF_BOARD, HEIGHT_OF_BOARD )
  boardBackground:setFillColor( 8 / 256, 11 / 256, 33 / 256 )
  local actionBarBackground = display.newRect( actionBarDisplayGroup, CENTER_OF_ACTION_BAR_X, HEIGHT_OF_ACTION_BAR / 2, WIDTH_OF_ACTION_BAR, HEIGHT_OF_ACTION_BAR )
  actionBarBackground:setFillColor( 1, .5, .5 )
  local infoBarBackground = display.newRect( infoBarDisplayGroup, CENTER_OF_INFO_BAR_X, HEIGHT_OF_INFO_BAR / 2, WIDTH_OF_INFO_BAR, HEIGHT_OF_INFO_BAR)
  infoBarBackground:setFillColor(.5, .5, 1)
  local animationAreaBackground = display.newRect( animationAreaDisplayGroup, CENTER_OF_ANIMATION_AREA_x, HEIGHT_OF_ANIMATION_AREA / 2, WIDTH_OF_ANIMATION_AREA, HEIGHT_OF_ANIMATION_AREA )
  animationAreaBackground:setFillColor(.5, 1, .5)
end

function loadSoundEffects()
  soundEffects.error = audio.loadSound(soundEffectsConfig.soundEffects.error)
  soundEffects.typewriter = {
    audio.loadSound(soundEffectsConfig.soundEffects.typewriter[1]),
    audio.loadSound(soundEffectsConfig.soundEffects.typewriter[2])
  }
end

function scene:create( event )
  composer.removeHidden()
  loadSoundEffects()

  primarySceneGroup = self.view
  primarySceneGroup:insert(boardDisplayGroup)
  primarySceneGroup:insert(infoBarDisplayGroup)
  primarySceneGroup:insert(actionBarDisplayGroup)
  primarySceneGroup:insert(animationAreaDisplayGroup)
  boardDisplayGroup.y = TOP_OF_BOARD
  actionBarDisplayGroup.y = TOP_OF_ACTION_BAR
  infoBarDisplayGroup.y = TOP_OF_INFO_BAR

  initBackgrounds()

  initInfoBar()

  controller.controlScene(scene, event.params.difficulty, event.params.characters)
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
