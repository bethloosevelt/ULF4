
local model = require("scenes.selection.selectionModel")

-- create images
function controlScene(selectionView)
  -- merge the character image data with the charater data
  local characters = model.characters
  selectionView:drawCharacterButtons(characters)
end

-- buttons on the front end are passed a single image to be initialized. they are given a name
-- that is the character ID.
-- add IDs to the character config. make them uuids? couldn't hurt I guess.
-- the onClicked fn passes back an ID to a clicked function in the controller, which then
-- builds the new model to pass to the front end.
-- then the view iterates over the new set of images, comparing IDs with what is already displayed
-- essentially DIFFing the two things and making the necessary updates
