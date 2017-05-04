
local images = {}

images.backgrounds = {
    startScreen = {
        filePath = "assets/images/backgrounds/logo.png"
    }
}

local buttonsBaseDir = "assets/images/buttons/"
images.buttons = {
    startGame = {
        defaultFilePath = buttonsBaseDir .. "playButton.png",
        overFilePath = buttonsBaseDir .. "playButtonDown.png"
    },
    characterSelectAccept = {
      defaultFilePath = buttonsBaseDir .. "playButton.png",
      overFilePath = buttonsBaseDir .. "playButtonDown.png"
    },
    difficulties = {
        easy = {
            defaultFilePath = buttonsBaseDir .. "easy.png"
        },
        medium = {
            defaultFilePath = buttonsBaseDir .. "medium.png"
        },
        hard = {
            defaultFilePath = buttonsBaseDir .. "hard.png"
        }
    },
    selected = {
        defaultFilePath = buttonsBaseDir .. "selected.png"
    }
}

local characterSelectImagesBaseDir = "assets/images/characterImages/"
images.characterSelectImages = {
  hpLovecraft =
    {
      defaultFilePath = characterSelectImagesBaseDir .. "hpLovecraft.png",
      overFilePath = characterSelectImagesBaseDir .. "hpLovecraftOver.png"
    },
  williamShakespere =
    {
      defaultFilePath = characterSelectImagesBaseDir .. "williamShakespere.png",
      overFilePath = characterSelectImagesBaseDir .. "williamShakespereOver.png"
    },
  oscarWilde =
    {
      defaultFilePath = characterSelectImagesBaseDir .. "oscarWilde.png",
      overFilePath = characterSelectImagesBaseDir .. "oscarWilde.png"
    },
  markTwain =
    {
      defaultFilePath = characterSelectImagesBaseDir .. "markTwain.jpg",
      overFilePath = characterSelectImagesBaseDir .. "markTwainOver.jpg"
    },
  janeAusten =
    {
      defaultFilePath = characterSelectImagesBaseDir .. "janeAusten.png",
      overFilePath = characterSelectImagesBaseDir .. "janeAustenOver.png"
    }
}

return images
