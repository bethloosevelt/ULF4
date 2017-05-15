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

function table.binsearch( t, value, fcompval, reversed )

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
     value = value:lower()
     value2 = value2:lower()
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
