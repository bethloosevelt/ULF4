displayObjectTransformers = {}

displayObjectTransformers.scaleToScreenX = function(image, paddingOnEachSide)
  local scaleFactor = (display.contentWidth / (image.width + (paddingOnEachSide * 2)))
	image:scale(scaleFactor, scaleFactor)
end

return displayObjectTransformers
