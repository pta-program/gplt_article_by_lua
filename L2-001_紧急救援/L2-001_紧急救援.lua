-- 实现原理：Dijkstra 维护最短路条数与最短路可召集队伍数；同距离时选择队伍数更多的前驱。
local n,m,s,d=io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)%s+(%d+)"); n,m,s,d=tonumber(n),tonumber(m),tonumber(s),tonumber(d); local teams={}; for x in io.read("*l"):gmatch("%d+") do teams[#teams+1]=tonumber(x) end; local g={}; for i=0,n-1 do g[i]={} end
for _=1,m do local a,b,w=io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)"); a,b,w=tonumber(a),tonumber(b),tonumber(w); g[a][b]=w; g[b][a]=w end
local dist,ways,rescue,pre,used={}, {}, {}, {}, {}; for i=0,n-1 do dist[i]=math.huge end; dist[s],ways[s],rescue[s]=0,1,teams[s]
for _=1,n do local u=nil; for i=0,n-1 do if not used[i] and (not u or dist[i]<dist[u]) then u=i end end; if not u then break end; used[u]=true; for v,w in pairs(g[u]) do local nd=dist[u]+w; if nd<dist[v] then dist[v],ways[v],rescue[v],pre[v]=nd,ways[u],rescue[u]+teams[v],u elseif nd==dist[v] then ways[v]=ways[v]+ways[u]; if rescue[u]+teams[v]>rescue[v] then rescue[v],pre[v]=rescue[u]+teams[v],u end end end end
local path={}; local x=d; while x do table.insert(path,1,x); x=pre[x] end; print(ways[d].." "..rescue[d]); print(table.concat(path," "))
