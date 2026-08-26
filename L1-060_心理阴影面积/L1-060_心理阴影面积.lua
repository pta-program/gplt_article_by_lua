-- 实现原理：阴影是顶点为 (0,0)、(x,y)、(100,100) 的三角形，面积为 (x-y)*100/2。
local x, y = io.read("*l"):match("(%d+)%s+(%d+)")
print((tonumber(x) - tonumber(y)) * 50)
