-- L3-026 传送门
--
-- 实现原理：机器人自下而上穿越传送门；同一高度的一对传送门等价于对当前横坐标
-- 作一次交换。每次修改后按高度重放全部交换，得到 f(x)，再累加 x*f(x)。

local n,q=io.read('*n','*n');local portals={}
for _=1,q do
 local line=io.read('*l');while line and line:match('^%s*$') do line=io.read('*l') end
 local op,x,y,h=line:match('(%S+)%s+(%d+)%s+(%d+)%s+(%d+)')
 x,y,h=tonumber(x),tonumber(y),tonumber(h);local key=x..':'..y..':'..h
 if op=='+' then portals[key]={x=x,y=y,h=h} else portals[key]=nil end
 local arr={};for _,v in pairs(portals) do arr[#arr+1]=v end;table.sort(arr,function(a,b)return a.h<b.h end)
 local f={};for i=1,n do f[i]=i end
 for _,v in ipairs(arr) do
  for i=1,n do if f[i]==v.x then f[i]=v.y elseif f[i]==v.y then f[i]=v.x end end
 end
 local ans=0;for i=1,n do ans=ans+i*f[i] end;print(ans)
end
