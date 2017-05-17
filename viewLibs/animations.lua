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

animations.shrinkFromRight = function(obj, amount)
  amount = math.abs(obj.path.x3) + amount
  transition.to( obj.path, { time=500, x3=-amount, x4=-amount} )
end

animations.shrinkFromLeft = function(obj, amount)
  amount = obj.path.x1 + amount
  transition.to( obj.path, { time=500, x1=amount, x2=amount} )
end

animations.shrinkHorizontal = function(obj)
  transition.to(obj, { time = 100, width = 0 })
end

animations.growHorizontal = function(obj, width)
  transition.to(obj, { time = 100, width = width })
end

function getQuadrant(obj, coordinates)
  local x, y = coordinates.x, coordinates.y
  if math.abs(x) < 30 and math.abs(y) < 30 then
    return "center"
  end
  if math.abs(x) < 30 and y > 30 then
    return "bottom"
  end
  if x < -30 and y > 30 then
    return "bottomleft"
  end
  if x > 30 and y > 30 then
    return "bottomright"
  end
  if math.abs(x) < 30 and y < -30 then
    return "top"
  end
  if x < -30 and y < -30 then
    return "topleft"
  end
  if x > 30 and y < -30 then
    return "topright"
  end
  if x < -30 and math.abs(y) < 30 then
    return "left"
  end
  if x > 30 and math.abs(y) < 30 then
    return "right"
  end
end

animations.tilt = function(obj, coordinates)
  local quadrant = getQuadrant(obj, coordinates)

  if quadrant == "center" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x1=10, y1=10, x2=10, y2=-10, x3=-10, y3=-10, x4=-10, y4=10 } )
  end
  if quadrant == "left" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x1=10, y1=10, x2=10, y2=-10 } )
  end
  if quadrant == "right" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x3=-10, y3=-10, x4=-10, y4=10 } )
  end
  if quadrant == "top" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x4=-10, y4=10, x1=10, y1=10 } )
  end
  if quadrant == "bottom" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x2=10, y2=-10, x3=-10, y3=-10 } )
  end
  if quadrant == "topright" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x4=-10, y4=10, x1=5, y1=5, x3=-5, y3=-5 } )
  end
  if quadrant == "bottomright" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x2=5, y2=-5, x3=-10, y3=-10, x4=-5, y4=5 } )
  end
  if quadrant == "topleft" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x4=-5, y4=5, x1=10, y1=10, x2=5, y2=-5 } )
  end
  if quadrant == "bottomleft" then
    animations.untilt(obj)
    transition.to( obj.path, { time=40, x2=10, y2=-10, x3=-5, y3=-5, x1=5, y1=5 } )
  end
end

return animations
