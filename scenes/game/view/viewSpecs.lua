-- view specs (to go in another file)
-- should tile specs be based on this? probably a subsection of this table

local viewSpecs = {}

local tileSpecs = {}
tileSpecs.width = display.contentWidth / 4
tileSpecs.height = display.contentWidth / 4
tileSpecs.x = function(index) return ((((index - 1) % 4) + 1) * tileSpecs.width) - (0.5 * tileSpecs.width) end
tileSpecs.y = function(index) return ((math.floor((index - 1) / 4) + 1) * tileSpecs.height) - (0.5 * tileSpecs.height)  end


viewSpecs.boardViewSpecs = {
  x = function() return display.contentWidth / 2 end,
  y = function() return display.contentHeight / 2 end,
  tileSpecs = tileSpecs,
  width = function() return display.contentWidth end
}

return viewSpecs
