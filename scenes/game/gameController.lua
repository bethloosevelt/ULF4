local modelModule = require("scenes.game.gameModel")

local controller = {}

controller.controlScene = function(view, difficulty, characters)
  local model = modelModule.initModel(difficulty, characters.player1, characters.player2)
  view:replaceBoard(model.gameBoard)
end

return controller
