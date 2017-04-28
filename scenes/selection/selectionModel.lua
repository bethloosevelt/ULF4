local selectionModel = {}

local characters = require("sharedModels.characters")
local images = require("configs.images")
local scenes = require("scenes.scenes")

selectionModel.characters = characters
selectionModel.characterImages = images.characterImages
selectionModel.acceptButtonImages = images.buttons.characterSelectAccept
selectionModel.nextScene = scenes.game

return selectionModel
