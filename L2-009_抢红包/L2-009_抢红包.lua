-- 实现原理：发红包者扣除金额，抢到者增加金额并计一次；按余额、次数、编号排序。
local n=tonumber(io.read("*l")); local money,count={},{}; for i=1,n do money[i],count[i]=0,0 end
for sender=1,n do local v={}; for x in io.read("*l"):gmatch("%d+") do v[#v+1]=tonumber(x) end; for j=1,v[1] do local to,amount=v[2*j],v[2*j+1]; money[sender]=money[sender]-amount; money[to]=money[to]+amount; count[to]=count[to]+1 end end
local ids={}; for i=1,n do ids[i]=i end; table.sort(ids,function(a,b) return money[a]~=money[b] and money[a]>money[b] or (count[a]~=count[b] and count[a]>count[b] or a<b) end); for _,i in ipairs(ids) do print(string.format("%d %.2f",i,money[i]/100)) end
