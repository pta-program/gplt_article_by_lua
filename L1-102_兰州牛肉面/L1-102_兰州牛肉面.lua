-- 实现原理：按品种累计售出碗数，最后用各品种数量乘单价累加营业额。
local n=tonumber(io.read("*l")); local price={}; for x in io.read("*l"):gmatch("[%d.]+") do price[#price+1]=tonumber(x) end; local sold={}; for i=1,n do sold[i]=0 end
while true do local id,count=io.read("*l"):match("(%d+)%s+(%d+)"); id,count=tonumber(id),tonumber(count); if id==0 then break end; sold[id]=sold[id]+count end
local total=0; for i=1,n do print(sold[i]); total=total+sold[i]*price[i] end; print(string.format("%.2f",total))
