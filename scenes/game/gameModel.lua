local gameModelModule= {}
local characters = require("configs.characters")

-- perhaps
function player(characterID)
  return {
    score = 0,
    lastWord = "",
    character = characters[characterID]
  }
end

function randomLetter()
    letters = "AAAAAAAAABBCCDDDDEEEEEEEEEEEEFFGGGHHIIIIIIIIIJKLLLLMMNNNNNNOOOOOOOOPPQRRRRRRSSSSTTTTTTUUUUVVWWXYYZ"
    index = math.random(string.len(letters))
    return string.sub(letters, index, index)
end

gameModelModule.newBoard = function(size)
  newBoard = {{}, {}, {}, {}}
  for i=1, size do
    for j=1, size do
      newBoard[i][j] = randomLetter()
    end
  end
  return newBoard
end

gameModelModule.initModel = function(difficulty, characterID1, characterID2)
  local model = {}
  model.player1 = player(characterID1)
  model.player2 = player(characterID2)
  model.gameBoard = gameModelModule.newBoard(4)
  return model
end

return gameModelModule
