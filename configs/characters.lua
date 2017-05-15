
local powers = require("configs.powers")
local uuid = require("langUtils.uuid")
require("langUtils.tableUtils")

local characterModule = {}
characterModule.characters = {
  williamShakespere = {
    id = "williamShakespere",
    displayName = "William Shakespere",
    power = powers.swap,
    baseHealth = 200
  },
  hpLovecraft = {
    id = "hpLovecraft",
    displayName = "H.P. Lovecraft",
    power = powers.void,
    baseHealth = 200
  },
  oscarWilde = {
    id = "oscarWilde",
    displayName = "Oscar Wilde",
    power = "",
    baseHealth = 200
  },
  markTwain = {
    id = "markTwain",
    displayName = "Mark Twain",
    power = "",
    baseHealth = 200
  },
  janeAusten = {
    id = "janeAusten",
    displayName = "Jane Austen",
    power = "",
    baseHealth = 200
  }
}

return characterModule
