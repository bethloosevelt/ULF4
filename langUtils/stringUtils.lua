
-- expands language to allow indexing of strings like so: "abcd"[2] -> "b"
getmetatable('').__index = function(str,i) return string.sub(str,i,i) end
