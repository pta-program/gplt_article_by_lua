-- 实现原理：按位置切出剪贴板内容后删除，再在最靠前的“前串+后串”连接处插入。
local text=io.read("*l"); local n=tonumber(io.read("*l"))
for _=1,n do local l,r,before,after=io.read("*l"):match("(%d+)%s+(%d+)%s+(%S+)%s+(%S+)"); l,r=tonumber(l),tonumber(r); local clip=text:sub(l,r); text=text:sub(1,l-1)..text:sub(r+1); local p=text:find(before..after,1,true); if p then p=p+#before; text=text:sub(1,p-1)..clip..text:sub(p) else text=text..clip end end
print(text)
