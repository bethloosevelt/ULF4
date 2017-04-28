
local model = require("scenes.selection.selectionModel")

-- create images
function controlScene(selectionView)
  -- merge the character image data with the charater data
  local characters = model.characters
  local characterSelectImages = model.characterSelectImages
  for key, index in pairs(characters) do
    characters[key].characterButtonImage = characterSelectImages[key].default
  end
  selectionView:drawCharacterButtons(characters)
end

function characterChosen(character)
