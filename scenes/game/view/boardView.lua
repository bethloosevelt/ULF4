
local buttons = require("viewLibs.buttons")
local sprites = require("viewLibs.sprites")

function tile(parent)
  return sprites.alphabet(parent)
end

function board(parent)
  newBoard = {{}, {}, {}, {}}
  for rowI=1, 4 do
    for tileI=1, 4  do
      newBoard[rowI][tileI] = tile(parent)
      newBoard[rowI][tileI].coordinates = {x=tileI, y=rowI}
    end
  end
  return newBoard
end

return board
