
table.take = function(table, n)
    result = {}
    for i=0, n do
        result[#result + 1] = table[i]
    end
    return result
end

table.concat = function(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

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

table.map = function(t, fn)
  r = {}
  for k, v in pairs(t) do
    r[k] = fn(v)
  end
  return t
end

table.reduce = function(t, fn, base)
  for k, v in pairs(t) do
    base = fn(base, v)
  end
  return base
end

table.print = function(tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    for key, value in pairs (tt) do
      io.write(string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        if #value > 100 then
            io.write(":)")
        else
            done [value] = true
            io.write(string.format("[%s] => table\n", tostring (key)));
            io.write(string.rep (" ", indent+4)) -- indent it
            io.write("(\n");
            table.print(value, indent + 7, done)
            io.write(string.rep (" ", indent+4)) -- indent it
            io.write(")\n");
        end
      else
        io.write(string.format("[%s] => %s\n",
            tostring (key), tostring(value)))
      end
    end
  else
    io.write(tt .. "\n")
  end
end

table.binsearch = function( t, value, fcompval, reversed )

  local fcompval = function( value ) return value end
  local fcomp = function( a,b )
    return a < b
  end

  local fcompr = function( a,b )
    return a > b
  end

  local iStart,iEnd,iMid = 1,#t,0
  -- Binary Search
  while iStart <= iEnd do
     -- calculate middle
     iMid = math.floor( (iStart+iEnd)/2 )
     -- get compare value
     local value2 = fcompval( t[iMid] )
     -- get all values that match
     value = string.lower(value)
     value2 = string.lower(value2)
     if value == value2 then
        local tfound,num = { iMid,iMid },iMid - 1
        while value == fcompval( t[num] ) do
           tfound[1],num = num,num - 1
        end
        num = iMid + 1
        while value == fcompval( t[num] ) do
           tfound[2],num = num,num + 1
        end
        return tfound
     -- keep searching
     elseif fcomp( value, value2 ) then
        iEnd = iMid - 1
     else
        iStart = iMid + 1
     end
  end
end
