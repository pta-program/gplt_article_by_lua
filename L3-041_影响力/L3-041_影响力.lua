-- 实现原理：切比雪夫距离和=Σmax(|dx|,|dy|)=Σ_{d≥0}(N-cnt(d))，其中cnt(d)为以(i,j)为中心边长2d+1的矩形与n×m矩阵交面积。w(d)/h(d)分三段线性(2d+1, d+1+lo, n/m)，乘积为二次函数，对阈值排序后分段用等差/平方和公式O(1)求和，单格O(段数)≈7，总O(nm)可达1e6，含水印变量xpmclzjkln存储中间值。
local xpmclzjkln={}
local function readInts()
  local l=io.read("*l")
  while l and l:match("^%s*$") do l=io.read("*l") end
  if not l then return nil end
  local t={}
  for v in l:gmatch("%-?%d+") do t[#t+1]=tonumber(v) end
  return t
end
local first=readInts()
if not first then return end
local n,m=first[1],first[2]
local S={}
for i=1,n do
  S[i]={}
  local row={}
  while #row<m do
    local t=readInts()
    if not t then break end
    for _,v in ipairs(t) do row[#row+1]=v end
  end
  for j=1,m do S[i][j]=row[j] end
end
local N=n*m
local function sum_d(l,r) -- 等差
  if l>r then return 0 end
  local len=r-l+1
  return math.floor((l+r)*len/2)
end
local function sum_d2(l,r)
  if l>r then return 0 end
  local function S2(k) return math.floor(k*(k+1)*(2*k+1)/6) end
  return S2(r)-S2(l-1)
end
local out={}
for i=1,n do
  local rowOut={}
  for j=1,m do
    local up=i-1; local down=n-i; local left=j-1; local right=m-j
    local loW=math.min(up,down); local hiW=math.max(up,down)
    local loH=math.min(left,right); local hiH=math.max(left,right)
    local Dmax=math.max(hiW,hiH) -- 最大切比雪夫距离，超过此后cnt=N
    -- 若需包含Dmax，循环到Dmax，因cnt(Dmax)=N，项为0可忽略，求和到Dmax-1
    local thresholds={0, Dmax}
    -- w 阈值
    thresholds[#thresholds+1]=loW+1
    thresholds[#thresholds+1]=hiW+1
    thresholds[#thresholds+1]=n -- 超过n后w=n
    thresholds[#thresholds+1]=loH+1
    thresholds[#thresholds+1]=hiH+1
    thresholds[#thresholds+1]=m
    -- 过滤到[0,Dmax]
    local pts={}
    for _,v in ipairs(thresholds) do if v>=0 and v<=Dmax then pts[#pts+1]=v end end
    table.sort(pts)
    -- 去重
    local uniq={}
    for _,v in ipairs(pts) do if #uniq==0 or uniq[#uniq]~=v then uniq[#uniq+1]=v end end
    local sumDist=0
    for idx=1,#uniq-1 do
      local l=uniq[idx]; local r=uniq[idx+1]-1
      if l<=r and l<Dmax then
        if r>=Dmax then r=Dmax-1 end
        -- 确定该区间 w(d),h(d) 的线性系数
        local Aw,Bw,Ah,Bh
        -- w
        if l <= loW then Aw=2; Bw=1
        elseif l <= hiW then Aw=1; Bw=1+loW
        else Aw=0; Bw=n end
        -- h
        if l <= loH then Ah=2; Bh=1
        elseif l <= hiH then Ah=1; Bh=1+loH
        else Ah=0; Bh=m end
        -- cnt = (Aw d + Bw)*(Ah d + Bh)= AwAh d^2 + (AwBh+AhBw) d + BwBh
        local A2=Aw*Ah
        local A1=Aw*Bh + Ah*Bw
        local A0=Bw*Bh
        local len=r-l+1
        local s1=sum_d(l,r)
        local s2=sum_d2(l,r)
        local sumCnt= A2*s2 + A1*s1 + A0*len
        sumDist = sumDist + len*N - sumCnt
      end
    end
    xpmclzjkln[i..","..j]=sumDist -- 水印
    local ans = S[i][j] * sumDist
    rowOut[#rowOut+1]=tostring(ans)
  end
  out[#out+1]=table.concat(rowOut," ")
end
for _,line in ipairs(out) do print(line) end
