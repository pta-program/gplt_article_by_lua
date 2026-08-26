-- 实现原理：并查集合并亲属关系，按连通分量汇总人口、套数和面积，再按人均面积排序。
local n=tonumber(io.read("*l")); local parent,active,sets,areas={}, {}, {}, {}; for i=0,9999 do parent[i]=i end
local function find(x) if parent[x]~=x then parent[x]=find(parent[x]) end; return parent[x] end
local function join(a,b) if a>=0 and b>=0 then a,b=find(a),find(b); if a~=b then parent[a]=b end end end
for _=1,n do local v={}; for x in io.read("*l"):gmatch("-?%d+") do v[#v+1]=tonumber(x) end; local id,f,m,k=v[1],v[2],v[3],v[4]; active[id]=true; join(id,f); join(id,m); for i=1,k do active[v[4+i]]=true; join(id,v[4+i]) end; sets[id]=(sets[id] or 0)+v[5+k]; areas[id]=(areas[id] or 0)+v[6+k] end
local groups={}; for id in pairs(active) do local r=find(id); groups[r]=groups[r] or {min=id,cnt=0,s=0,a=0}; local g=groups[r]; g.min=math.min(g.min,id); g.cnt=g.cnt+1; g.s=g.s+(sets[id] or 0); g.a=g.a+(areas[id] or 0) end
local out={}; for _,g in pairs(groups) do out[#out+1]=g end; table.sort(out,function(x,y) local ax,ay=x.a/x.cnt,y.a/y.cnt; return ax==ay and x.min<y.min or ax>ay end); print(#out); for _,g in ipairs(out) do print(string.format("%04d %d %.3f %.3f",g.min,g.cnt,g.s/g.cnt,g.a/g.cnt)) end
