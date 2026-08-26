-- 实现原理：所有非零猜测必须与实际帽子一致，且至少有一个非零猜测才获奖。
local n=tonumber(io.read("*l")); local hats={}; for x in io.read("*l"):gmatch("%d+") do hats[#hats+1]=tonumber(x) end; local k=tonumber(io.read("*l"))
for _=1,k do local any,ok=false,true; local i=0; for x in io.read("*l"):gmatch("%d+") do i=i+1; x=tonumber(x); if x~=0 then any=true; if x~=hats[i] then ok=false end end end; print(any and ok and "Da Jiang!!!" or "Ai Ya") end
