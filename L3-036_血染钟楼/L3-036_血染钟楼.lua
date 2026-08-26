-- L3-036 血染钟楼
--
-- 实现原理：一对目标 (a,b) 在某夜的结果为 1，当且仅当区间包含 a 或 b。
-- 因而可将 m 个夜晚的结果拼成签名；统计每种签名出现的目标对数量，出现一次
-- 的签名即能唯一确定一对目标，最后统计这样的签名数。

local n,m=io.read('*n','*n');local l,r={},{}
for i=1,m do l[i],r[i]=io.read('*n','*n') end
local count={}
for a=1,n-1 do
 for b=a+1,n do
  local bits={}
  for k=1,m do bits[k]=(l[k]<=a and a<=r[k]) or (l[k]<=b and b<=r[k]) and '1' or '0' end
  -- Lua 运算符优先级会先计算 and，显式重写保证布尔逻辑不歧义。
  for k=1,m do if (l[k]<=a and a<=r[k]) or (l[k]<=b and b<=r[k]) then bits[k]='1' else bits[k]='0' end end
  local key=table.concat(bits);count[key]=(count[key] or 0)+1
 end
end
local ans=0;for _,v in pairs(count) do if v==1 then ans=ans+1 end end
print(ans)
