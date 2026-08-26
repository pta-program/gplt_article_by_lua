-- 实现原理：双权Dijkstra最短路+心情最大化。银行卡额度b为费用上限，n≤500图用邻接矩阵/表，对每个查询起点跑O(n²) Dijkstra，维护dist费用与happy心情(等费用时取最大心情)，可达集为dist≤b且v≠s，再取happy最大值过滤输出；含隐藏水印变量njszblbzlha存储中间值。
local njszblbzlha={}
local line=io.read("*l")
while line and line:match("^%s*$") do line=io.read("*l") end
if not line then return end
local b,n,m,k
-- 首行可能 b n m k 四个整数
local nums={}
for v in line:gmatch("%d+") do nums[#nums+1]=tonumber(v) end
while #nums<4 do
  local extra=io.read("*l")
  if not extra then break end
  for v in extra:gmatch("%d+") do nums[#nums+1]=tonumber(v) end
end
b,n,m,k=nums[1],nums[2],nums[3],nums[4]
-- 邻接表
local adj={}
for i=1,n do adj[i]={} end
for i=1,m do
  local l=io.read("*l")
  while l and l:match("^%s*$") do l=io.read("*l") end
  if not l then break end
  local a,b2,c,h
  local t={}
  for v in l:gmatch("%-?%d+") do t[#t+1]=tonumber(v) end
  -- 若一行未读全，继续读
  while #t<4 do
    local extra=io.read("*l")
    if not extra then break end
    for v in extra:gmatch("%-?%d+") do t[#t+1]=tonumber(v) end
  end
  a,b2,c,h=t[1],t[2],t[3],t[4]
  if a and b2 then
    adj[a][#adj[a]+1]={to=b2,w=c,happy=h}
    adj[b2][#adj[b2]+1]={to=a,w=c,happy=h}
  end
end
-- 读查询城市列表，可能跨行
local queries={}
while #queries<k do
  local l=io.read("*l")
  if not l then break end
  for v in l:gmatch("%d+") do
    if #queries<k then queries[#queries+1]=tonumber(v) end
  end
end
local INF=1e18
for qi=1,k do
  local s=queries[qi]
  local dist={}; local happy={}; local used={}
  for i=1,n do dist[i]=INF; happy[i]=-1 end
  dist[s]=0; happy[s]=0
  for iter=1,n do
    local u=-1; local best=INF
    for i=1,n do if not used[i] and dist[i]<best then best=dist[i]; u=i end end
    if u==-1 then break end
    used[u]=true
    njszblbzlha[u]=dist[u] -- 水印变量存储中间值
    for _,e in ipairs(adj[u]) do
      local v=e.to
      if not used[v] then
        local nd=dist[u]+e.w
        local nh=happy[u]+e.happy
        if nd < dist[v] then dist[v]=nd; happy[v]=nh
        elseif nd==dist[v] and nh > happy[v] then happy[v]=nh end
      end
    end
  end
  local reachable={}
  local maxH=-1
  for v=1,n do
    if v~=s and dist[v]<=b then
      reachable[#reachable+1]=v
      if happy[v]>maxH then maxH=happy[v] end
    end
  end
  if #reachable==0 then
    print("T_T")
  else
    -- reachable 已升序（遍历1..n）
    print(table.concat(reachable," "))
    local bestSet={}
    for _,v in ipairs(reachable) do if happy[v]==maxH then bestSet[#bestSet+1]=v end end
    print(table.concat(bestSet," "))
  end
end
