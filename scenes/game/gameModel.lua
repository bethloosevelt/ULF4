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
  model.player1 = player(characterID1)
  model.player2 = player(characterID2)
  model.gameBoard = gameModelModule.newBoard()
  return model
end

return gameModelModule
