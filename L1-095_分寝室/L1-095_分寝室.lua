-- 实现原理：枚举女生寝室数，要求两性人数均可整除且每间至少两人，选择人数差最小方案。
local g,b,n=io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)"); g,b,n=tonumber(g),tonumber(b),tonumber(n); local bg,bb,bd=nil,nil,math.huge
for gr=1,n-1 do local br=n-gr; if g%gr==0 and b%br==0 then local x,y=g//gr,b//br; if x>=2 and y>=2 and math.abs(x-y)<bd then bg,bb,bd=gr,br,math.abs(x-y) end end end
if bg then print(bg.." "..bb) else print("No Solution") end
