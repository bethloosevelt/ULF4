local animations = {}

animations.pulse = function(obj)
  transition.to(obj, { time = 80, xScale = 1.09, yScale = 1.09 })
  transition.to(obj, { delay = 80, time = 300, xScale = 1, yScale = 1 })
end

animations.squeez = function(obj)
  print("SQUEEZING")
  transition.to(obj, { time = 40, xScale = .95, yScale = .95 })
end

animations.release = function(obj)
  transition.to(obj, { time = 40, xScale = 1, yScale = 1 })
end

return animations
