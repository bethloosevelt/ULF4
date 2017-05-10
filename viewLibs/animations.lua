local animations = {}

animations.pulse = function(obj)
  transition.to(obj, { time = 80, xScale = 1.09, yScale = 1.09 })
  transition.to(obj, { delay = 80, time = 300, xScale = 1, yScale = 1 })
end

animations.squeez = function(obj)
  transition.to(obj, { time = 40, xScale = .95, yScale = .95 })
end

animations.release = function(obj)
  transition.to(obj, { time = 40, xScale = 1, yScale = 1 })
end

animations.untilt = function(obj)
  transition.to( obj.path, { time=40, x1=0, y1=0, x2=-0, y2=0, x3=0, y3=0, x4=-0, y4=0 } )
end

animations.tiltRandom = function(obj)
  local direction = math.random(1, 4)
  if direction == 1 then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x1=10, y1=10, x2=10, y2=-10 } )
  end
  if direction == 2 then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x2=10, y2=-10, x3=-10, y3=-10 } )
  end
  if direction == 3 then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x3=-10, y3=-10, x4=-10, y4=10 } )
  end
  if direction == 4 then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x4=-10, y4=10, x1=10, y1=10 } )
  end
end

return animations
