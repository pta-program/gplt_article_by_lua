-- L3-033 教科书般的亵渎
--
-- 实现原理：第一张牌未击杀任何敌人时，每次选择仍等概率为 1/n。状态 DP 记录
-- 每名敌人累计受击次数；K 次后，第二张牌可清场当且仅当剩余血量的不同取值连续。

local MOD=998244353;local n,K=io.read('*n','*n');local hp={}
for i=1,n do hp[i]=io.read('*n') end
local function modpow(a,e)local r=1;while e>0 do if e%2==1 then r=r*a%MOD end;a=a*a%MOD;e=e//2 end;return r end
local invn=modpow(n,MOD-2);local dp={['']=1}
for _=1,K do
 local nd={}
 for key,val in pairs(dp) do
  local hit={};for x in key:gmatch('%d+') do hit[#hit+1]=tonumber(x) end;while #hit<n do hit[#hit+1]=0 end
  for i=1,n do if hit[i]+1<hp[i] then
   hit[i]=hit[i]+1;local t=table.concat(hit,',');nd[t]=((nd[t] or 0)+val*invn)%MOD;hit[i]=hit[i]-1
  end end
 end;dp=nd
end
local ans=0
for key,val in pairs(dp) do
 local hit={};for x in key:gmatch('%d+') do hit[#hit+1]=tonumber(x) end;while #hit<n do hit[#hit+1]=0 end
 local seen,minv,maxv={},math.huge,0
 for i=1,n do local v=hp[i]-hit[i];seen[v]=true;minv=math.min(minv,v);maxv=math.max(maxv,v) end
 local ok=true;for v=minv,maxv do if not seen[v] then ok=false;break end end
 if ok then ans=(ans+val)%MOD end
end
print(ans)
