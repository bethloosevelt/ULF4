
local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")
local tableUtils = require("langUtils.tableUtils")
local mathUtils = require("langUtils.mathUtils")

-- our packages
local controller = require("scenes.selection.selectionController")
local gridProperties = nil
local displayGroups = {
  title = display.newGroup(),
  characterButtons = display.newGroup(),
  accept = display.newGroup()
}
local buttonTable = {}

function selected(event)
  controller.procSelectEvent(event.target, scene)
end

function drawCharacter(character, index)
  local button = buttons.imageButton(gridProperties.imageWidth, gridProperties.imageHeight, selected, character.imageToDisplay())
  button.x = gridProperties.x(index)
  button.y = gridProperties.y(index)
  button.id = character.id
  button.isSelected = character.isSelected
  button.index = index
  displayGroups.characterButtons:insert(button)
  buttonTable[index] = button
end

-- consider making the grid different sizes
function calibrateGrid(characters)
  gridProperties = {}
  gridProperties.characterCount = tableUtils.count(characters)
  gridProperties.size = math.ceil(math.sqrt(gridProperties.characterCount))

  gridProperties.paddingOnEachSide = 15
  gridProperties.imageWidth = (display.contentWidth - gridProperties.size) / gridProperties.size
  gridProperties.imageHeight = gridProperties.imageWidth
  -- make this easier to read
                                            -- index of x in grid
  gridProperties.x = function(index) return ((((index - 1)%gridProperties.size) + 1) * gridProperties.imageWidth) - (0.5 * gridProperties.imageWidth) end
  gridProperties.y = function(index) return ((math.floor((index - 1) / gridProperties.size) + 1) * gridProperties.imageHeight) - (0.5 * gridProperties.imageHeight)  end
  return gridProperties
end

function scene:drawCharacterButtons(characters)
  local gridProperties = calibrateGrid(characters)
  local index = 1
  for characterKey, character in pairs(characters) do
    drawCharacter(character, index)
    index = index + 1
  end
end

function redrawButton(button, character)
  local index = button.index
  button:removeSelf()
  drawCharacter(character, index)
end

function scene:update(characters)
  for buttonKey, button in pairs(buttonTable) do
    local idsMatch = function(character) return character.id == button.id end
    local character = characters[tableUtils.where(characters, idsMatch)]
    if button.isSelected ~= character.isSelected then
      redrawButton(button, character)
    end
  end
end

-- entry point
function scene:create( event )
  -- insert groups into main display group
  local primarySceneGroup = self.view
  for key, group in pairs(displayGroups) do
    primarySceneGroup:insert(group)
  end
  controller.controlScene(scene)
end

function scene:destroy( event )
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
