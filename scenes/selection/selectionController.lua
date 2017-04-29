
local model = require("scenes.selection.selectionModel")
local tableUtils = require("langUtils.tableUtils")

local controller = {}

-- create images
controller.controlScene = function(selectionView)
  -- merge the character image data with the charater data
  local characters = model.characters
  selectionView:drawCharacterButtons(characters)
end

controller.procSelectEvent = function(eventTarget, selectionView)
  local characters = model.characters
  local idSMatch = function(character) return character.id == eventTarget.id end
  local selectedCharacterKey = tableUtils.where(characters, idSMatch)
  for characterKey, character in pairs(characters) do
    character.isSelected = false
  end
  characters[selectedCharacterKey].isSelected = true
  selectionView:update(characters)
end

return controller
