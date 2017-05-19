local modelModule = require("scenes.game.gameModel")
require("langUtils.stringUtils")
local scoring = require("configs.scoring")
local controller = {}
local model = nil
local gameScene = nil
local enemyAi = require("ai.baseAi")

controller.controlScene = function(scene, difficulty, chosenCharacters)
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
  local currentPlayer = model.turn
  if isValidTile(coordinates, currentPlayer) then
    model[currentPlayer].currentWord = model[currentPlayer].currentWord .. model.gameBoard[coordinates.y][coordinates.x]
    model[currentPlayer].selectedTiles[#model[currentPlayer].selectedTiles + 1] = coordinates
    gameScene.updateInfoBar(model[currentPlayer].currentWord)
    gameScene.updateActionBar(scoring.ofWord(model[currentPlayer].currentWord))
    return true
  end
  return false
end

controller.resetCurrentCharacter = function()
  local currentPlayer = model.turn
  gameScene.clearSelections(model[currentPlayer].selectedTiles)
  model[currentPlayer].currentWord = ""
  model[currentPlayer].selectedTiles = {}
  gameScene.updateInfoBar(model[currentPlayer].currentWord)
  gameScene.updateActionBar(0)
end

controller.otherPlayer = function(player)
  if player == "player1" then return "player2" end
  if player == "player2" then return "player1" end
end

controller.loseHealth = function(player, amount)
  gameScene.processAttack(amount / model[player].character.baseHealth, player)
  model[player].currentHealth = model[player].currentHealth - amount
end

controller.takeAiTurn = function(cb)
  local enemyWord, newBoard, aiSelectedTiles = enemyAi.makeMove(model.gameBoard, model.aiWords, model.difficulty)
  print(enemyWord)
  gameScene.clearSelections(model.player1.selectedTiles)
  controller.resetCurrentCharacter()
  gameScene.displayTileSelections(aiSelectedTiles)
  timer.performWithDelay( 500 * (#aiSelectedTiles + 1), function()
      controller.loseHealth("player1", scoring.ofWord(enemyWord))
      gameScene.clearSelections(aiSelectedTiles)
      cb()
  end)
end

controller.attackActivated = function()
  if model.isValidPlayerWord(model.player1.currentWord) then
    local score = scoring.ofWord(model.player1.currentWord)
    controller.loseHealth("player2", score)
    model.turn = controller.otherPlayer(model.turn)
    controller.takeAiTurn(function()
      controller.refreshBoard(gameScene)
      gameScene.updateActionBar(0)
      controller.resetCurrentCharacter()
      model.turn = controller.otherPlayer(model.turn)
      controller.resetCurrentCharacter()
    end)
  else
      controller.resetCurrentCharacter()
  end
end

return controller
