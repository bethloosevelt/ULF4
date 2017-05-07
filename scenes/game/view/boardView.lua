
local buttons = require("viewLibs.buttons")
local tileImages = require("configs.tiles")
local viewSpecs = require("scenes.game.view.viewSpecs")

function tileButton(image)
  local tileSpecs = viewSpecs.boardViewSpecs.tileSpecs
  local foo = function() print("asd") end
  return buttons.imageButton(tileSpecs.height, tileSpecs.width, foo, image)
end

function tile(letter)
  print(letter)
  print(tileImages[letter])
  return tileButton(tileImages[letter])
end

function board(boardModel)
  newBoard = {{}, {}, {}, {}}
  for rowI, row in pairs(boardModel) do
    for tileI, letter in pairs(row) do
      newBoard[rowI][tileI] = tile(letter)
    end
  end
  return newBoard
end

return board
