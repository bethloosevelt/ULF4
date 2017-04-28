
local images = {}

images.backgrounds = {
    startScreen = {
        filePath = "assets/images/backgrounds/logo.png"
    }
}

images.buttons = {
    startGame = {
        defaultFilePath = "assets/images/buttons/playButton.png",
        overFilePath = "assets/images/buttons/playButtonDown.png"
    },
    characterSelectAccept = {
      defaultFilePath = "assets/images/buttons/playButton.png",
      overFilePath = "assets/images/buttons/playButtonDown.png"
    }
}

images.characterSelectImages = {
  hpLoveCraft =
    {
      defaultFilePath = "assets/images/characterImages/hpLovecraft.png",
      overFilePath = "assets/images/characterImages/hpLovecraftOver.png"
    },
  williamShakespere =
    {
      defaultFilePath = "assets/images/characterImages/williamShakespere.png",
      overFilePath = "assets/images/characterImages/williamShakespereOver.png"
    },
  oscarWilde =
    {
      defaultFilePath = "assets/images/characterImages/oscarWilde.png",
      overFilePath = "assets/images/characterImages/oscarWilde.png"
    }
}

return images
