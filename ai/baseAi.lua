local baseAi = {}

local scoring = require("configs.scoring")
local difficultyConfig = require("configs.difficulty")

local selectingWord = nil
local selectedTiles = {}

local function getAdjacentTiles(x, y, board)
  local result = {}
  for newX=(x - 1),(x + 1) do
    for newY=(y - 1),(y + 1) do
        local sameTile = newX == x and newY == y
        local inBounds = (newX >= 1 and newX <= #board) and (newY >= 1 and newY <= #(board[1]))
        if not sameTile and inBounds then
          result[#result + 1] = {x=newX, y=newY}
        end
    end
  end
  return result
end

function inBoard(word, board, x, y, acc)
    if word == "" then
        selectedTiles[selectingWord] = acc
        return true
    end
    if string.lower(board[x][y]) == string.sub(word, 1, 1) then
      local adjacentTiles = getAdjacentTiles(x, y, board)
      for i=1, #adjacentTiles do
          local tile = adjacentTiles[i]
          if inBoard(string.sub(word, 2), board, tile['x'], tile['y'], table.add(acc, {x=x, y=y})) then
            return true
          end
      end
    end
    return false
end

local function getValidWordsInBoard(board, words)
    local result = {}
    for x=1, #board do
      for y=1, #(board[1]) do
        for i=1,#words do
            selectingWord = words[i]
            if inBoard(words[i], board, x, y, {{x=x, y=y}}) then
              result[#result + 1] = words[i]
            end
        end
      end
    end
    return result
end

baseAi.makeMove = function(boardModel, possibleWords, difficulty)
    if difficulty == difficultyConfig.difficulties.easy.level then
      possibleWords = table.take(possibleWords, 1000)
    elseif difficulty == difficultyConfig.difficulties.medium.level then
      possibleWords = table.take(possibleWords, 10000)
    end

    local validWords = getValidWordsInBoard(boardModel, possibleWords)
    local bestWord = function(word1, word2)
      if scoring.ofWord(word1) > scoring.ofWord(word2) then
        return word1
      else
        return word2
      end
    end

    local chosenWord = table.reduce(validWords, bestWord, "a")

    local finalSelectedTiles = selectedTiles[chosenWord]
    selectedTiles = {}
    selectedWord = nil

    return chosenWord, boardModel, finalSelectedTiles
end

return baseAi
