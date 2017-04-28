
local widget = require "widget"

local buttons = {}

buttons.imageButton = function (height, width, onReleaseFn, image)
	local newButton = widget.newButton {
		defaultFile = image,
    overFile = images.over,
		width=width, height=height,
		onRelease = onReleaseFn
	}
	return newButton
end

return buttons
