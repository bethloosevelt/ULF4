local animations = {}

animations.pulse = function(obj)
  transition.to(obj, { time = 80, xScale = 1.09, yScale = 1.09 })
  transition.to(obj, { delay = 100, time = 300, xScale = 1, yScale = 1 })
end

return animations
