local spritesConfig = require("configs.sprites")

local sprites = {}

sprites.alphabet = function(parent)
  local alphabetSpriteSheetConfig = spritesConfig.spriteSheets.alphabet
  local sheetOptions = {
    numFrames = alphabetSpriteSheetConfig.frames,
    width = alphabetSpriteSheetConfig.frameWidth,
    height = alphabetSpriteSheetConfig.frameHeight
  }
  local sequenceData = {
      name = "alphabet",
      start = 1,
      count = alphabetSpriteSheetConfig.frames
  }
  local imageSheet = graphics.newImageSheet( alphabetSpriteSheetConfig.filePath, sheetOptions )
  local newSprite = display.newSprite( parent, imageSheet, sequenceData )
  local scaleFactor = display.contentWidth / 4 / alphabetSpriteSheetConfig.frameWidth
  newSprite:scale(scaleFactor, scaleFactor)
  return newSprite
end

return sprites
