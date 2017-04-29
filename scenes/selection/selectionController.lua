
local model = require("scenes.selection.selectionModel")
require("langUtils.tableUtils")

local controller = {}

controller.controlScene = function(selectionView)
  local characters = model.characters
  selectionView:drawCharacterButtons(characters)
end

controller.procSelectEvent = function(eventTarget, selectionView)
  local characters = model.characters
  local idsMatch = function(character) return character.id == eventTarget.id end
  local selectedCharacterKey = table.where(characters, idsMatch)
  for characterKey, character in pairs(characters) do
    character.isSelected = false
  end
  model.selectedCharacterId = eventTarget.id
  characters[selectedCharacterKey].isSelected = true
  selectionView:update(characters)
end

return controller
