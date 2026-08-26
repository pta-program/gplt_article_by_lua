-- L3-012 水果忍者
--
-- 实现原理：可行域的边界一定经过某些线段端点。枚举两个端点确定的直线，
-- 用 y=(p*x+b)/q 的整数形式比较，避免浮点误差；找到穿过全部线段者即输出
-- 直线上 x=0、x=q 的两点（坐标均为整数）。

local n=io.read('*n');local a={}
for i=1,n do a[i]={x=io.read('*n'),hi=io.read('*n'),lo=io.read('*n')} end
if n==1 then print(a[1].x..' '..a[1].lo..' '..a[1].x..' '..a[1].hi);return end
local function check(p,q,b)
 for _,z in ipairs(a) do local v=p*z.x+b;if v<z.lo*q or v>z.hi*q then return false end end
 return true
end
for i=1,n-1 do for j=i+1,n do
 if a[i].x~=a[j].x then
  for _,yi in ipairs({a[i].lo,a[i].hi}) do for _,yj in ipairs({a[j].lo,a[j].hi}) do
   local p,q=yj-yi,a[j].x-a[i].x;if q<0 then p,q=-p,-q end
   local b=yi*q-p*a[i].x
   if check(p,q,b) then print('0 '..b..' '..q..' '..(p+b));return end
  end end
 end
end end
-- 兜底：水平线同样可能是可行域的内部解。
for _,z in ipairs(a) do if check(0,1,z.lo) then print('0 '..z.lo..' 1 '..z.lo);return end end
