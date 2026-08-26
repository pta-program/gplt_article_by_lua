-- 实现原理：双智能体贪心分配+最近邻TSP启发式。维护Oriol(7,7)/David(8,8)当前位置，对每组20点按到当前位置欧氏距离就近分配，单体内用最近邻排序估算路径长度，累计时间=max(distO,distD)/2，预算120s内逐组尝试，首包输出0的平凡解被替换为启发式分配确保合法且非占位。
local function dist(x1,y1,x2,y2) local dx=x1-x2; local dy=y1-y2; return math.sqrt(dx*dx+dy*dy) end
local function tsp_len(sx,sy, pts)
  if #pts==0 then return 0 end
  local used={} ; local curx,cury=sx,sy; local tot=0
  for _=1,#pts do
    local best=-1; local bd=1e100
    for i,p in ipairs(pts) do if not used[i] then local d=dist(curx,cury,p[1],p[2]); if d<bd then bd=d; best=i end end end
    tot=tot+bd; curx,cury=pts[best][1],pts[best][2]; used[best]=true
  end
  return tot
end
local T=io.read("*n")
if not T then T=0 end
for _=1,T do
  local groups={} -- 20 x 20 points
  for g=1,20 do
    local pts={}
    for p=1,20 do
      local x=io.read("*n"); local y=io.read("*n")
      if not x then x=0 end; if not y then y=0 end
      pts[p]={x,y}
    end
    groups[g]=pts
  end
  local ox,oy=7,7; local dx,dy=8,8
  local time_used=0
  local N=0
  local assigns={} -- per group {Ba, Bb, listO, listD}
  for g=1,20 do
    local pts=groups[g]
    -- try assignment: nearest agent
    local setO={}; local setD={}
    local idxO={}; local idxD={}
    for i,p in ipairs(pts) do
      local dO=dist(ox,oy,p[1],p[2])
      local dD=dist(dx,dy,p[1],p[2])
      if dO<=dD then table.insert(setO,p); table.insert(idxO,i-1) else table.insert(setD,p); table.insert(idxD,i-1) end
    end
    -- balance if one side empty and other many, keep as is; otherwise try to improve by local swaps (simple)
    local lenO=tsp_len(ox,oy,setO)
    local lenD=tsp_len(dx,dy,setD)
    local need=math.max(lenO,lenD)/2
    if time_used+need <= 120+1e-9 then
      time_used=time_used+need
      -- update positions to last visited point of each agent (approx nearest neighbor last)
      -- recompute last positions by simulating nearest order to get endpoint
      local function endpoint(sx,sy,pts)
        if #pts==0 then return sx,sy end
        local curx,cury=sx,sy; local used={}
        for _=1,#pts do
          local best=-1; local bd=1e100
          for i,p in ipairs(pts) do if not used[i] then local d=dist(curx,cury,p[1],p[2]); if d<bd then bd=d; best=i end end end
          curx,cury=pts[best][1],pts[best][2]; used[best]=true
        end
        return curx,cury
      end
      ox,oy=endpoint(ox,oy,setO)
      dx,dy=endpoint(dx,dy,setD)
      N=N+1
      assigns[N]={Ba=#idxO, Bb=#idxD, O=idxO, D=idxD}
    else
      break
    end
  end
  print(N)
  for i=1,N do
    local a=assigns[i]
    print(a.Ba.." "..a.Bb)
    if a.Ba>0 then print(table.concat(a.O," ")) else print("") end
    if a.Bb>0 then print(table.concat(a.D," ")) else print("") end
  end
  -- 若 N==0 仅输出0，已满足格式
end
