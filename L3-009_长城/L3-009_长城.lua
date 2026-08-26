-- L3-009 长城
--
-- 实现原理：从南向北扫描折线顶点。能作为“向北瞭望”边界的烽火台构成一条
-- 可见凸链；新顶点加入时，若中间顶点落在两端连线下方（或共线），它不会提供
-- 新的遮挡边界，可从栈中删除。最终可见链除总部外的顶点数即为建台数。

local n=io.read('*n');local p={}
for i=1,n do p[i]={x=io.read('*n'),y=io.read('*n')} end
local st={}
local function cross(a,b,c)
 return (b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x)
end
for i=1,n do
 while #st>=2 and cross(st[#st-1],st[#st],p[i])<=0 do st[#st]=nil end
 st[#st+1]=p[i]
end
print(math.max(0,#st-1))
