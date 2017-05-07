local modelModule = require("scenes.game.gameModel")

local controller = {}
local model = nil

controller.controlScene = function(view, difficulty, characters)
  model = modelModule.initModel(difficulty, characters.player1, characters.player2)
  view.createBoard(model.gameBoard)
end

controller.refreshBoard = function(scene)
  model.gameBoard = modelModule.newBoard()
  scene.updateBoardSprites(model.gameBoard)
end

controller.processTileTouch = function(coordinates, scene)
  print(model.gameBoard[coordinates.y][coordinates.x])
end

return controller
