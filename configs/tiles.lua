
require("langUtils.stringUtils")

local tiles = {}
-- this is silly. I don't care. Sorry dad
local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
for i=1, 26 do
  tiles[alphabet[i]] = "assets/images/tiles/" .. alphabet[i] .. ".png"
end
return tiles
