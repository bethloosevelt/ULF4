local mathUtils = {}

mathUtils.round = function(num)
  return math.floor(num + .5)
end

return mathUtils
