-- L3-032 关于深度优先搜索和逆序对的题应该不会很难吧这件事
--
-- 实现原理：DFS 序数量为每个结点的“孩子数阶乘”之积。祖先一定先于后代，
-- 用 Euler 序和 Fenwick 统计这类固定逆序；不在祖先链上的两点属于某处不同
-- 子树，它们的相对顺序在孩子排列中恰有一半情况形成逆序。

local MOD=1000000007
local n,root=io.read('*n','*n');local g={}
for i=1,n do g[i]={} end
for _=1,n-1 do local u,v=io.read('*n','*n');g[u][#g[u]+1]=v;g[v][#g[v]+1]=u end
local par,child,tin,tout,order={}, {},{}, {},{}
for i=1,n do child[i]=0 end
local st={{root,0,1}};par[root]=0;local timer=0
while #st>0 do
 local z=st[#st]
 if z[3]==1 then timer=timer+1;tin[z[1]]=timer;order[timer]=z[1];z[3]=2
 elseif z[2]<=#g[z[1]] then z[2]=z[2]+1;local v=g[z[1]][z[2]];if v~=par[z[1]] then par[v]=z[1];child[z[1]]=child[z[1]]+1;st[#st+1]={v,0,1} end
 else tout[z[1]]=timer;st[#st]=nil end
end
local fac={1};for i=1,n do fac[i]=fac[i-1]*i%MOD end
local ways=1;for i=1,n do ways=ways*fac[child[i]]%MOD end
local bit={};for i=1,n do bit[i]=0 end
local function add(i) while i<=n do bit[i]=bit[i]+1;i=i+(i&-i) end end
local function sum(i) local r=0;while i>0 do r=r+bit[i];i=i-(i&-i) end;return r end
local fixed=0
for label=1,n do
 fixed=fixed+(sum(tout[label])-sum(tin[label]-1));add(tin[label])
end
local ancestorPairs=0;for u=1,n do ancestorPairs=ancestorPairs+(tout[u]-tin[u]) end
local allPairs=n*(n-1)/2;local incomparable=allPairs-ancestorPairs
local inv2=(MOD+1)//2
local ans=ways*((fixed%MOD+incomparable%MOD*inv2)%MOD)%MOD
print(ans)
