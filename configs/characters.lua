
local powers = require("configs.powers")
local uuid = require("langUtils.uuid")

local characters = {
  williamShakespere = {
    id = "shakespere",
    displayName = "William Shakespere",
    power = powers.swap,
    baseHealth = 200
  },
  hpLovecraft = {
    id = "lovecraft",
    displayName = "H.P. Lovecraft",
    power = powers.void,
    baseHealth = 200
  },
  oscarWilde = {
    id = "oscarwilde",
    displayName = "Oscar Wilde",
    power = "",
    baseHealth = 200
  },
  markTwain = {
    id = "marktwain",
    displayName = "Mark Twain",
    power = "",
    baseHealth = 200
  },
  janeAusten = {
    id = "janeausten",
    displayName = "Jane Austen",
    power = "",
    baseHealth = 200
  }
}

return characters
