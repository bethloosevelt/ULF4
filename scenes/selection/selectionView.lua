
local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")

-- our packages
local displayObjectTransformers = require("controllerLibs.displayObjectTransformers")
local selectionController = require("scenes.selection.selectionController")

local displayGroups = {
  title = display.newGroup(),
  characterButtons = display.newGroup(),
  accept = display.newGroup()
}

function drawCharacter(character, index, gridProperties)
  local function foo() = print(character.displayName)
  local button = buttons.imageButton(gridProperties.imageWidth, gridProperties.imageHeight, foo, character.characterButtonImages)
  button.x = gridProperties.x(index)
  button.y = gridProperties.y(index)
  displayGroups.characterButtons:insert(button)
end

-- consider making the grid different sizes
function calibrateGrid(characters)
  local characterCount = #characters
  local gridProperties = {}
  gridProperties.characterCount = characterCount
  gridProperties.cols = math.sqrt(characterCount)
  gridProperties.rows = gridProperties.cols
  gridProperties.totalPaddingBetweenEachImage = 20
  gridProperties.imageWidth = (screen.contentWidth - (gridProperties.totalPaddingBetweenEachImage * gridProperties.cols)) / gridProperties.cols
  gridProperties.imageHeight = gridProperties.imageHeight
  gridProperties.x = function(index) (index * (gridProperties.imageWidth + gridProperties.totalPaddingBetweenEachImage)) - (.5 * gridProperties.imageWidth) end
  gridProperties.y = function(index) (index * (gridProperties.imageHeight + gridProperties.totalPaddingBetweenEachImage)) - (.5 * gridProperties.imageHeight) end
  return gridProperties
end

function drawCharacterButtons(characters)
  local gridProperties = calibrateGrid(characters)
  for character, index in pairs(characters) do
    drawCharacter(character, index, gridProperties)
  end
end

-- entry point
function scene:create( event )
  -- insert groups into main display group
  controlScene(scene)
end

function scene:destroy( event )
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
