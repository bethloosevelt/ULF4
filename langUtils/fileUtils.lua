local fileUtils = {}

fileUtils.readLinesFromFile = function(relativeFilePath)
  local words = {}
  for line in io.lines(system.pathForFile(relativeFilePath)) do
    words[#words + 1] = line
  end
  print("tryna load " .. relativeFilePath)
  return words
end

return fileUtils
