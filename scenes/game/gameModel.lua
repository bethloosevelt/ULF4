local gameModelModule= {}
local characterModule = require("configs.characters")
local characters = characterModule.characters
local fileUtils = require("langUtils.fileUtils")
local wordsConfig = require("configs.words")

-- perhaps
function player(characterID)
  newPlayer = {
    score = 0,
    wordsUsed = {},
    currentWord = "",
    selectedTiles = {}
  }
  newPlayer.character = characterModule.characters[characterID]
  newPlayer.currentHealth = newPlayer.character.baseHealth
  return newPlayer
end

function randomLetter()
    letters = "AAAAAAAAABBCCDDDDEEEEEEEEEEEEFFGGGHHIIIIIIIIIJKLLLLMMNNNNNNOOOOOOOOPPQRRRRRRSSSSTTTTTTUUUUVVWWXYYZ"
    index = math.random(string.len(letters))
    return string.sub(letters, index, index)
end

gameModelModule.newBoard = function()
  newBoard = {{}, {}, {}, {}}
  for i=1, 4 do
    for j=1, 4 do
      newBoard[i][j] = randomLetter()
    end
  end
  return newBoard
end

function loadAcceptedWords()
  return fileUtils.readLinesFromFile(wordsConfig.playerWords.filePath)
end

function loadAiWords()
  return fileUtils.readLinesFromFile(wordsConfig.aiWords.filePath)
end

gameModelModule.initModel = function(difficulty, characterID1, characterID2)
  local model = {}
  model.winner = nil
  model.turn = "player1"
  model.difficulty = difficulty
  model.player1 = player(characterID1)
  model.player2 = player(characterID2)
  model.gameBoard = gameModelModule.newBoard()
  model.playerWords = loadAcceptedWords()
  model.aiWords = loadAiWords()
  model.isValidPlayerWord = function(word) return table.binsearch(model.playerWords, word) ~= nil end
  return model
end

return gameModelModule
