
local widget = require "widget"

local buttons = {}

buttons.imageButton = function (height, width, onReleaseFn, images)
	local newButton = widget.newButton {
		defaultFile = images.default,
    overFile = images.over,
		width=width, height=height,
		onRelease = onReleaseFn
	}
	return newButton
end

return buttons
