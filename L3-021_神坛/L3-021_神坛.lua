-- L3-021 神坛
--
-- 实现原理：三角形两倍面积等于两条边叉积的绝对值。枚举任意三块神石，维护
-- 最小两倍面积；坐标重合或三点共线时叉积为零，会立即成为最优答案。

local n=io.read('*n');local p={}
for i=1,n do p[i]={io.read('*n'),io.read('*n')} end
local best=math.huge
for i=1,n-2 do for j=i+1,n-1 do
 local x1,y1=p[j][1]-p[i][1],p[j][2]-p[i][2]
 for k=j+1,n do
  local s=math.abs(x1*(p[k][2]-p[i][2])-y1*(p[k][1]-p[i][1]))
  if s<best then best=s end
  if best==0 then break end
 end
 if best==0 then break end
end if best==0 then break end end
print(string.format('%.3f',best/2))
