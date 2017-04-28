
local powers = require("sharedModels.powers")

local characters = {
  williamShakespere = {
    displayName = "William Shakespere",
    power = powers.swap,
    baseHealth = 200
  },
  hpLovecraft = {
    displayName = "H.P. Lovecraft",
    power = powers.void,
    baseHealth = 200
  },
  oscarWilde = {
    displayName = "Oscar Wilde",
    power = "",
    baseHealth = 200
  }
}

return characters