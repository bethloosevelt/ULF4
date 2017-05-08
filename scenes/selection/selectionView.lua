
local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"
local buttons = require("viewLibs.buttons")
require("langUtils.tableUtils")
require("langUtils.mathUtils")

-- our packages
local controller = require("scenes.selection.selectionController")
local gridProperties = nil
local displayGroups = {
  title = display.newGroup(),
  difficultyButtons = display.newGroup(),
  characterButtons = display.newGroup(),
  startGame = display.newGroup()
}
scene.displayGroups = displayGroups
local buttonTable = {}
local difficultyIndicator = nil

function selected(event)
  controller.procSelectEvent(event.target, scene)
end

function selectedDifficulty(event)
  controller.procSelectDifficultyEvent(event.target, scene)
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
  gridProperties.characterCount = table.count(characters)
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

function drawDifficultyIndicator(difficulty)
  -- maybe put view constraints in a single place
  local rowHeight = .08 * display.contentHeight
  local rowWidth = display.contentWidth
  local distanceFromBottom = display.contentHeight - .4 * display.contentHeight
  local buttonWidth = rowWidth / 3
  local new = false
  if not difficultyIndicator then
    local newButton = buttons.imageButton(rowHeight, buttonWidth, selectedDifficulty, difficulty.buttonImage)
    difficultyIndicator = newButton
    new = true
  end
  local x, y = nil, nil
  y = distanceFromBottom - (.5*rowHeight)
  if difficulty.level == "easy" then
      x = 1*buttonWidth - .5*(buttonWidth)
  end
  if difficulty.level == "medium" then
      x = 2*buttonWidth - .5*(buttonWidth)
  end
  if difficulty.level == "hard" then
      x = 3*buttonWidth - .5*(buttonWidth)
  end
  if not new then
    transition.moveTo( difficultyIndicator, { x=x, y=y, time=100 } )
  else
    difficultyIndicator.x = x
    difficultyIndicator.y = y
  end
end
function drawDifficultyButton(difficulty)
    -- maybe put view constraints in a single place
    local rowHeight = .08 * display.contentHeight
    local rowWidth = display.contentWidth
    local distanceFromBottom = display.contentHeight - .4 * display.contentHeight
    local buttonWidth = rowWidth / 3
    local newButton = buttons.imageButton(rowHeight, buttonWidth, selectedDifficulty, difficulty.buttonImage)
    displayGroups.difficultyButtons:insert(newButton)
    newButton.difficulty = difficulty.level
    newButton.y = distanceFromBottom - (.5*rowHeight)
    if difficulty.level == "easy" then
        newButton.x = 1*buttonWidth - .5*(buttonWidth)
    end
    if difficulty.level == "medium" then
        newButton.x = 2*buttonWidth - .5*(buttonWidth)
    end
    if difficulty.level == "hard" then
        newButton.x = 3*buttonWidth - .5*(buttonWidth)
    end
end

function scene:drawDifficultyButtons(difficulties)
    for key, difficulty in pairs(difficulties) do
        drawDifficultyButton(difficulty, false)
    end
end

function startGame()
  controller.startGame(composer)
end

function scene:drawStartGameButton(startGameImage)
  newButton = buttons.imageButton(50, 200, startGame, startGameImage)
  displayGroups.startGame:insert(newButton)
  newButton.x = display.contentWidth / 2
  newButton.y = display.contentHeight - 50
end
function scene:drawSelectedIndicator(image, level)
  local difficulty = {}
  difficulty.level = level
  difficulty.buttonImage = image
  drawDifficultyIndicator(difficulty)
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
    local character = characters[table.where(characters, idsMatch)]
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
  for key, button in pairs(buttonTable) do
    if button then
      button:removeSelf()
    end
  end
  if difficultyIndicator then
    difficultyIndicator:removeSelf()
  end
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "update", scene )

return scene
