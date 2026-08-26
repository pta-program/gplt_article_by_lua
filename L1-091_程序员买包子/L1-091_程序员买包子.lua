-- 实现原理：最终数量等于 N、M 或其他数量，对应三种固定结论。
local n, item, m, k = io.read("*l"):match("(%d+)%s+(%S+)%s+(%d+)%s+(%d+)")
if k == n then print("mei you mai " .. item .. " de") elseif k == m then print("kan dao le mai " .. item .. " de") else print("wang le zhao mai " .. item .. " de") end
