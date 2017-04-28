local selectionModel = {}

local characters = require("configs.characters")
local images = require("configs.images")
local scenes = require("scenes.scenes")

selectionModel.characters = characters
selectionModel.characterSelectImages = images.characterSelectImages
selectionModel.acceptButtonImages = images.buttons.characterSelectAccept
selectionModel.nextScene = scenes.game

return selectionModel
