local selectionModel = {}

local characters = require("configs.characters")
local images = require("configs.images")
local scenes = require("scenes.scenes")
local difficulty = require("configs.difficulty")

local charactersForSelectionScreen = characters

local characterSelectImages = images.characterSelectImages
for key, index in pairs(characters) do
  characters[key].images = characterSelectImages[key]
  characters[key].isSelected = false
  characters[key].imageToDisplay = function() if characters[key].isSelected then return characters[key].images.overFilePath else return characters[key].images.defaultFilePath end end
end

selectionModel.difficulties = difficulty.difficulties
local difficulyButtonImages = images.buttons.difficulties
for key, val in pairs(selectionModel.difficulties) do
    val.buttonImage = difficulyButtonImages[key].defaultFilePath
end

selectionModel.selectedButtonImage = images.buttons.selected.defaultFilePath
selectionModel.characters = charactersForSelectionScreen
selectionModel.nextScene = scenes.game
selectionModel.selectedCharacterId = nil
selectionModel.selectedDifficulty = nil

return selectionModel
