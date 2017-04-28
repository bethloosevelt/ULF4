
local model = require("selectionModel")

-- create images
function controlScene(slectionView)
  -- merge the character image data with the charater data
  characters = model.characters
  characterImages = model.characterImages
  for key, index in pairs(characters) do
    characters[key].characterButtonImages = characterImages[key]
  end
  selectionView:drawCharacterButtons(characters)
end
