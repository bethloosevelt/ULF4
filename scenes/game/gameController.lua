local modelModule = require("scenes.game.gameModel")

local controller = {}
local model = nil

controller.controlScene = function(view, difficulty, chosenCharacters)
  print(chosenCharacters.player1)
  model = modelModule.initModel(difficulty, chosenCharacters.player1, chosenCharacters.player2)
  view.createBoard(model.gameBoard)
end

controller.refreshBoard = function(scene)
  model.gameBoard = modelModule.newBoard()
  scene.updateBoardSprites(model.gameBoard)
end

function isValidTile(coordinates, player)
  local lastTileTouched = model[player].lastTileTouched
  if lastTileTouched.x == nil or lastTileTouched.y == nil then
    return true
  end
  local dx = math.abs(lastTileTouched.x - coordinates.x)
  local dy = math.abs(lastTileTouched.y - coordinates.y)
  return dx <= 1 and dy <= 1
end

controller.processTileTouch = function(coordinates, scene)
  if isValidTile(coordinates, model.turn) then
    model.player1.currentWord = model.player1.currentWord .. model.gameBoard[coordinates.y][coordinates.x]
    model.player1.lastTileTouched = coordinates
    print(model.player1.character.displayName .. " is scoring the word: ")
    print(model.player1.currentWord)
    return true
  end
  return false

end

return controller
