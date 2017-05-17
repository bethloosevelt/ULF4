
local powers = require("configs.powers")
local uuid = require("langUtils.uuid")
require("langUtils.tableUtils")

local characterModule = {}
characterModule.characters = {
  williamShakespere = {
    id = "williamShakespere",
    displayName = "William Shakespere",
    power = powers.swap,
    baseHealth = 50
  },
  hpLovecraft = {
    id = "hpLovecraft",
    displayName = "H.P. Lovecraft",
    power = powers.void,
    baseHealth = 50
  },
  oscarWilde = {
    id = "oscarWilde",
    displayName = "Oscar Wilde",
    power = "",
    baseHealth = 50
  },
  markTwain = {
    id = "markTwain",
    displayName = "Mark Twain",
    power = "",
    baseHealth = 50
  },
  janeAusten = {
    id = "janeAusten",
    displayName = "Jane Austen",
    power = "",
    baseHealth = 50
  }
}

return characterModule
