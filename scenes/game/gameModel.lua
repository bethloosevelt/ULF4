local gameModelModule= {}
local characterModule = require("configs.characters")
local characters = characterModule.characters

-- perhaps
function player(characterID)
  return {
    score = 0,
    wordsUsed = {},
    currentWord = "",
    lastTileTouched = {x=nil, y=nil},
    character = characterModule.getCharacterByID(characterID)
  }
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

gameModelModule.initModel = function(difficulty, characterID1, characterID2)
  local model = {}
  model.turn = "player1"
  model.player1 = player(characterID1)
  model.player2 = player(characterID2)
  model.gameBoard = gameModelModule.newBoard()
  return model
end

return gameModelModule
