-- 实现原理：先让每人至多拥有 m-1 项技能，超出的总技能点必属于全能者。
local n,m=io.read("*l"):match("(%d+)%s+(%d+)"); local sum=0; for x in io.read("*l"):gmatch("%d+") do sum=sum+tonumber(x) end; print(math.max(0,sum-tonumber(n)*(tonumber(m)-1)))
