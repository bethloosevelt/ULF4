local modelModule = require("scenes.game.gameModel")
require("langUtils.stringUtils")
local scoring = require("configs.scoring")
local controller = {}
local model = nil
local gameScene = nil
local enemyAi = require("ai.baseAi")

controller.controlScene = function(scene, difficulty, chosenCharacters)
  print(chosenCharacters.player1)
  gameScene = scene
  model = modelModule.initModel(difficulty, chosenCharacters.player1, chosenCharacters.player2)
  scene.createBoard(model.gameBoard)
end

controller.refreshBoard = function(scene)
  model.gameBoard = modelModule.newBoard()
  scene.updateBoardSprites(model.gameBoard)
end

function isValidTile(coordinates, player)
  local lastTileTouched = model[player].selectedTiles[#model[player].selectedTiles]
  if lastTileTouched == nil or lastTileTouched.x == nil or lastTileTouched.y == nil then
    return true
  end
  local dx = math.abs(lastTileTouched.x - coordinates.x)
  local dy = math.abs(lastTileTouched.y - coordinates.y)
  return dx <= 1 and dy <= 1
end

controller.processTileTouch = function(coordinates, scene)
  if isValidTile(coordinates, model.turn) then
    model.player1.currentWord = model.player1.currentWord .. model.gameBoard[coordinates.y][coordinates.x]
    model.player1.selectedTiles[#model.player1.selectedTiles + 1] = coordinates
    scene.updateInfoBar(model.player1.currentWord)
    scene.updateActionBar(scoring.ofWord(model.player1.currentWord))
    return true
  end
  return false
end

controller.cancelCurrentAction = function(scene)
  scene.clearSelections(model.player1.selectedTiles)
  model.player1.currentWord = ""
  model.player1.selectedTiles = {}
  scene.updateInfoBar(model.player1.currentWord)
  scene.updateActionBar(0)
end

controller.otherPlayer = function(player)
  if player == "player1" then return "player2" end
  if player == "player2" then return "player1" end
end

controller.loseHealth = function(player, amount)
  gameScene.processAttack(amount / model[player].character.baseHealth, player)
  model[player].currentHealth = model[player].currentHealth - amount
end

controller.takeAiTurn = function()
  local enemyWord, newBoard = enemyAi.makeMove(model.gameBoard, model.aiWords, model.difficulty)
  controller.loseHealth("player1", scoring.ofWord(enemyWord))
end

controller.attackActivated = function()
  if model.isValidPlayerWord(model.player1.currentWord) then
    local score = scoring.ofWord(model.player1.currentWord)
    controller.loseHealth("player2", score)
    controller.takeAiTurn()
    controller.refreshBoard(gameScene)
  end
  controller.cancelCurrentAction(gameScene)
end

return controller
