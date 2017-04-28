
local model = require("scenes.selection.selectionModel")

-- create images
function controlScene(selectionView)
  -- merge the character image data with the charater data
  local characters = model.characters
  local characterSelectImages = model.characterSelectImages
  for key, index in pairs(characters) do
    characters[key].characterButtonImages = characterSelectImages[key]
  end
  selectionView:drawCharacterButtons(characters)
end
