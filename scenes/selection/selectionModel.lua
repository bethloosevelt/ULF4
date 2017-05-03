local selectionModel = {}

local characters = require("configs.characters")
local images = require("configs.images")
local scenes = require("scenes.scenes")

local charactersForSelectionScreen = characters
local characterSelectImages = images.characterSelectImages
for key, index in pairs(characters) do
  characters[key].images = characterSelectImages[key]
  characters[key].isSelected = false -- maybe unnecessarry
  characters[key].imageToDisplay = function() if characters[key].isSelected then return characters[key].images.overFilePath else return characters[key].images.defaultFilePath end end
end

selectionModel.characters = charactersForSelectionScreen
selectionModel.nextScene = scenes.game
selectionModel.selectedCharacterId = nil



return selectionModel
