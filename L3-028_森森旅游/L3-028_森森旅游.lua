-- L3-028 森森旅游
--
-- 实现原理：分别以现金边权从 1 求 distCash，以旅游金边权在反图从 n 求
-- distGold。若在 v 兑换，所需现金为 distCash[v]+ceil(distGold[v]/a[v])。
-- 每次只修改一个 v 的汇率，使用惰性最小堆维护所有候选值的最小值。

local n,m,q=io.read('*n','*n','*n')
local g,rg={},{}
for i=1,n do g[i]={};rg[i]={} end
for _=1,m do
 local u,v,c,d=io.read('*n','*n','*n','*n')
 g[u][#g[u]+1]={v,c,d}; rg[v][#rg[v]+1]={u,c,d}
end
local a={};for i=1,n do a[i]=io.read('*n') end
local function dij(start,adj,which)
 local dis,hv,hd,sz={}, {},{},0
 local function push(v,d)
  sz=sz+1;local i=sz
  while i>1 do local p=i//2;if hd[p]<=d then break end;hv[i],hd[i]=hv[p],hd[p];i=p end
  hv[i],hd[i]=v,d
 end
 local function pop()
  local v,d=hv[1],hd[1];local lv,ld=hv[sz],hd[sz];sz=sz-1;local i=1
  while i*2<=sz do local c=i*2;if c+1<=sz and hd[c+1]<hd[c] then c=c+1 end;if hd[c]>=ld then break end;hv[i],hd[i]=hv[c],hd[c];i=c end
  if sz>0 then hv[i],hd[i]=lv,ld end;return v,d
 end
 dis[start]=0;push(start,0)
 while sz>0 do local u,d=pop();if d==dis[u] then
  for _,e in ipairs(adj[u]) do local nd=d+e[which];if not dis[e[1]] or nd<dis[e[1]] then dis[e[1]]=nd;push(e[1],nd) end end
 end end
 return dis
end
local cash=dij(1,g,2);local gold=dij(n,rg,3)
local hv,hd,sz={}, {},0
local function push(v,d)
 sz=sz+1;local i=sz;while i>1 do local p=i//2;if hd[p]<=d then break end;hv[i],hd[i]=hv[p],hd[p];i=p end;hv[i],hd[i]=v,d
end
local function value(v)
 if not cash[v] or not gold[v] then return math.huge end
 return cash[v]+(gold[v]+a[v]-1)//a[v]
end
for i=1,n do push(i,value(i)) end
for _=1,q do
 local x,z=io.read('*n','*n');a[x]=z;push(x,value(x))
 while hd[1]~=value(hv[1]) do
  local lv,ld=hv[sz],hd[sz];sz=sz-1;local i=1
  while i*2<=sz do local c=i*2;if c+1<=sz and hd[c+1]<hd[c] then c=c+1 end;if hd[c]>=ld then break end;hv[i],hd[i]=hv[c],hd[c];i=c end
  if sz>0 then hv[i],hd[i]=lv,ld end
 end
 print(hd[1])
end
