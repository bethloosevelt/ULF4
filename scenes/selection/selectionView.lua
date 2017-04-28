
local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")
local tableUtils = require("langUtils.tableUtils")
local mathUtils = require("langUtils.mathUtils")

-- our packages
local selectionController = require("scenes.selection.selectionController")

local displayGroups = {
  title = display.newGroup(),
  characterButtons = display.newGroup(),
  accept = display.newGroup()
}

function drawCharacter(character, index, gridProperties)
  local foo = function() print(character.displayName) end
  local button = buttons.imageButton(gridProperties.imageWidth, gridProperties.imageHeight, foo, character.characterButtonImages)
  button.x = gridProperties.x(index)
  button.y = gridProperties.y(index)
  print(character.displayName .. " " .. index .. " " .. button.x .. " " .. button.y .. " " .. button.width .. " " .. button.height )
  displayGroups.characterButtons:insert(button)
end

-- consider making the grid different sizes
function calibrateGrid(characters)
  local gridProperties = {}
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
  print(#characters)
  local gridProperties = calibrateGrid(characters)
  local index = 1
  for characterKey, character in pairs(characters) do
    drawCharacter(character, index, gridProperties)
    index = index + 1
  end
end

-- entry point
function scene:create( event )
  -- insert groups into main display group
  local primarySceneGroup = self.view
  for key, group in pairs(displayGroups) do
    primarySceneGroup:insert(group)
  end
  controlScene(scene)
end

function scene:destroy( event )
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
