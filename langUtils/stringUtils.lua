
-- expands language to allow indexing of strings like so: "abcd"[2] -> "b"
getmetatable('').__index = function(str,i) return string.sub(str,i,i) end

string.letterToNumber = function(letter)
  local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  for i=1, 26 do
    if letters[i] == letter then
      return i
    end
  end
end
