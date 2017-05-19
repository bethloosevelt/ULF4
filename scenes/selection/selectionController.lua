
local scenes = require("scenes.scenes")
local model = require("scenes.selection.selectionModel")
require("langUtils.tableUtils")

local controller = {}

controller.controlScene = function(selectionView)
  selectionView:drawCharacterButtons(model.characters)
  selectionView:drawDifficultyButtons(model.difficulties)
  selectionView.displayGroups.difficultyButtons.isVisible = false
  selectionView:drawStartGameButton(model.startGameButton)
  selectionView.displayGroups.startGame.isVisible = false

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
  selectionView.displayGroups.difficultyButtons.isVisible = true
end

controller.procSelectDifficultyEvent = function(eventTarget, selectionView)
    model.selectedDifficulty = eventTarget.difficulty
    selectionView:drawSelectedIndicator(model.selectedButtonImage, eventTarget.difficulty)
    selectionView.displayGroups.startGame.isVisible = true
end

controller.startGame = function(composer)

  local characters = {
    player1 = model.selectedCharacterId,
    player2 = "hpLovecraft"
  }
  local params = {
    difficulty = model.selectedDifficulty,
    characters = characters
  }
  local options = {
  	    effect = "fade",
  	    time = 400,
        params = params
  }
  composer.gotoScene( scenes.game, options )
end

return controller
