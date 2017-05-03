table.count = function(t)
  local count = 0;
  for k, v in pairs(t) do
    count = count + 1
  end
  return count
end

-- finds first instance where predicate -> true
table.where = function(t, predicate)
  for k, v in pairs(t) do
    if predicate(v) then
      return k
    end
  end
  return nil
end

table.print = function(t)
  for k,v in pairs(t) do
    print(k .. " : " .. tostring(v))
  end
end
