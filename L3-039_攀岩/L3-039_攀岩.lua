-- L3-039 攀岩
--
-- 实现原理：以“任意两条手臂当前抓住的岩点对”为状态。若三点能被半径 r 的
-- 圆覆盖，第三臂即可抓住第三点并替换任一旧臂，所以该三点对应的三个状态两两
-- 连通。对 r 二分，并用并查集判断初始对 (1,2) 能否连到含 n 的状态。

local T=io.read('*n')
local function radius2(a,b,c)
 local ab=(a.x-b.x)^2+(a.y-b.y)^2;local ac=(a.x-c.x)^2+(a.y-c.y)^2;local bc=(b.x-c.x)^2+(b.y-c.y)^2
 local mx=math.max(ab,ac,bc)
 if mx*2>=ab+ac+bc then return mx/4 end
 local cross=math.abs((b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x))
 return ab*ac*bc/(4*cross*cross)
end
while T>0 do
 T=T-1;local n=io.read('*n');local p={}
 for i=1,n do p[i]={x=io.read('*n'),y=io.read('*n')} end
 local function id(a,b) if a>b then a,b=b,a end return (a-1)*n+b end
 local function ok(r)
  local parent={};local function find(x) parent[x]=parent[x] or x;if parent[x]~=x then parent[x]=find(parent[x]) end;return parent[x] end
  local function uni(x,y) x,y=find(x),find(y);if x~=y then parent[x]=y end end
  local rr=r*r
  for a=1,n-2 do for b=a+1,n-1 do for c=b+1,n do
   if radius2(p[a],p[b],p[c])<=rr+1e-10 then uni(id(a,b),id(a,c));uni(id(a,b),id(b,c)) end
  end end end
  local s=find(id(1,2))
  for x=1,n-1 do if find(id(x,n))==s then return true end end
  return false
 end
 local lo,hi=0,1500000
 for _=1,55 do local mid=(lo+hi)/2;if ok(mid) then hi=mid else lo=mid end end
 print(string.format('%.10f',hi))
end
