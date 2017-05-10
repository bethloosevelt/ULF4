
require("langUtils.tableUtils")
require("langUtils.mathUtils")
require("langUtils.stringUtils")

local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")
local soundEffectsConfig = require("configs.sounds")
local colors = require("configs.colors")
local fonts = require("configs.fonts")
local images = require("configs.images")
local animations = require("viewLibs.animations")

local controller = require("scenes.game.gameController")
local viewSpecs = require("scenes.game.view.viewSpecs")
local boardView = require("scenes.game.view.boardView")
local boardDisplayGroup = display.newGroup()

-- Action Bar References
local actionBarDisplayGroup = display.newGroup()
local powerButton = nil
local attackButton = nil
local cancelButton = nil

-- Info Bar References
local infoBarDisplayGroup = display.newGroup()
local currentWordLabel = nil

-- These need to be manually deleted when this scene ends
local disposables = {
  powerButton,
  attackButton,
  cancelButton
}

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

local BUTTON_HEIGHT = HEIGHT_OF_ACTION_BAR * .7
local BUTTON_WIDTH = BUTTON_HEIGHT * 1.61
local BUTTON_Y = HEIGHT_OF_ACTION_BAR / 2
local ATTACK_BUTTON_X = display.contentWidth / 2
local POWER_BUTTON_X = 20 + (BUTTON_WIDTH / 2)
local CANCEL_BUTTON_X = display.contentWidth - 20 - (BUTTON_WIDTH / 2)

local HEIGHT_OF_INFO_BAR = display.contentHeight * .07
local WIDTH_OF_INFO_BAR = display.contentWidth
local CENTER_OF_INFO_BAR_X = display.contentWidth / 2
local TOP_OF_INFO_BAR = TOP_OF_BOARD - HEIGHT_OF_INFO_BAR
local CURRENT_WORD_FONT_SIZE = HEIGHT_OF_INFO_BAR * .85

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
      tile:setFrame(string.letterToNumber(boardModel[rowKey][tileKey]))
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
        animations.pulse(attackButton)
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
    text = "",
    parent = infoBarDisplayGroup,
    x = display.contentWidth / 2,
    y = HEIGHT_OF_INFO_BAR / 2 + .1 * HEIGHT_OF_INFO_BAR,
    font = fonts.body,
    fontSize = CURRENT_WORD_FONT_SIZE
  })
end

scene.updateInfoBar = function(wordLabelText)
  currentWordLabel.text = wordLabelText
end

scene.updateActionBar = function(currentScore)
  attackButton:setLabel(tostring(currentScore))
end

function cancel()
  controller.cancelCurrentAction(scene)
end

function initActionBar()
  powerButton = widget.newButton({
		defaultFile = images.buttons.abilityBar.power.defaultFilePath,
    x = POWER_BUTTON_X,
    y = BUTTON_Y,
		width = BUTTON_WIDTH,
    height = BUTTON_HEIGHT,
		onRelease = controller.powerActivated
  })
  actionBarDisplayGroup:insert(powerButton)

  attackButton = widget.newButton({
		defaultFile = images.buttons.abilityBar.attack.defaultFilePath,
    x = ATTACK_BUTTON_X,
    y = BUTTON_Y,
		width = BUTTON_WIDTH,
    height = BUTTON_HEIGHT,
		onRelease = controller.attackActivated,
    font = fonts.body,
    fontSize = BUTTON_HEIGHT * .7,
    labelXOffset = -.15 * BUTTON_WIDTH,
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } }
  })

  attackButton:setLabel("0")
  actionBarDisplayGroup:insert(attackButton)

  cancelButton = widget.newButton({
		defaultFile = images.buttons.abilityBar.cancel.defaultFilePath,
    x = CANCEL_BUTTON_X,
    y = BUTTON_Y,
		width = BUTTON_WIDTH,
    height = BUTTON_HEIGHT,
		onRelease = cancel
  })
  actionBarDisplayGroup:insert(cancelButton)
end

function initBackgrounds()
  local boardBackground = display.newRect( boardDisplayGroup, CENTER_OF_BOARD_X, display.contentWidth / 2, WIDTH_OF_BOARD, HEIGHT_OF_BOARD )
  boardBackground:setFillColor(unpack(colors.DARK_BLUE))
  local actionBarBackground = display.newRect( actionBarDisplayGroup, CENTER_OF_ACTION_BAR_X, HEIGHT_OF_ACTION_BAR / 2, WIDTH_OF_ACTION_BAR, HEIGHT_OF_ACTION_BAR )
  actionBarBackground:setFillColor(unpack(colors.DARK_BLUE))
  local infoBarBackground = display.newRect( infoBarDisplayGroup, CENTER_OF_INFO_BAR_X, HEIGHT_OF_INFO_BAR / 2, WIDTH_OF_INFO_BAR, HEIGHT_OF_INFO_BAR)
  infoBarBackground:setFillColor(unpack(colors.DARK_BLUE))
  local animationAreaBackground = display.newRect( animationAreaDisplayGroup, CENTER_OF_ANIMATION_AREA_x, HEIGHT_OF_ANIMATION_AREA / 2, WIDTH_OF_ANIMATION_AREA, HEIGHT_OF_ANIMATION_AREA )
  animationAreaBackground:setFillColor(1, 1, 1)
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

  initActionBar()

  controller.controlScene(scene, event.params.difficulty, event.params.characters)
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
