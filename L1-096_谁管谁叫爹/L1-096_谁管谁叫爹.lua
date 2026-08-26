-- 实现原理：计算各位和，判断对方数字是否为该和的倍数；同真同假时比较原数大小。
local function ds(s) local r=0; for d in s:gmatch("%d") do r=r+tonumber(d) end; return r end
local n=tonumber(io.read("*l")); for _=1,n do local a,b=io.read("*l"):match("(%d+)%s+(%d+)"); local x,y=tonumber(a)%ds(b)==0,tonumber(b)%ds(a)==0; if x~=y then print(x and "A" or "B") else print(tonumber(a)>tonumber(b) and "A" or "B") end end
