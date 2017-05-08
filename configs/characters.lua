
local powers = require("configs.powers")
local uuid = require("langUtils.uuid")
require("langUtils.tableUtils")

local characterModule = {}
characterModule.characters = {
  williamShakespere = {
    id = uuid(),
    displayName = "William Shakespere",
    power = powers.swap,
    baseHealth = 200
  },
  hpLovecraft = {
    id = uuid(),
    displayName = "H.P. Lovecraft",
    power = powers.void,
    baseHealth = 200
  },
  oscarWilde = {
    id = uuid(),
    displayName = "Oscar Wilde",
    power = "",
    baseHealth = 200
  },
  markTwain = {
    id = uuid(),
    displayName = "Mark Twain",
    power = "",
    baseHealth = 200
  },
  janeAusten = {
    id = uuid(),
    displayName = "Jane Austen",
    power = "",
    baseHealth = 200
  }
}
characterModule.getCharacterByID = function(id)
  local key = table.where(characterModule.characters, function(character) return character.id == id end)
  return characterModule.characters[key]
end

return characterModule
