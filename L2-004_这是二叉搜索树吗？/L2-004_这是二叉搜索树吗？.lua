-- 实现原理：按普通 BST 和镜像 BST 的范围递归验证前序序列，验证成功后递归生成后序序列。
local n=tonumber(io.read("*l")); local a={}; for x in io.read("*l"):gmatch("-?%d+") do a[#a+1]=tonumber(x) end
local function build(l,r,mirror,out) if l>r then return true end; local root=a[l]; local p=l+1; if not mirror then while p<=r and a[p]<root do p=p+1 end; for i=p,r do if a[i]<root then return false end end else while p<=r and a[p]>=root do p=p+1 end; for i=p,r do if a[i]>=root then return false end end end; if not build(l+1,p-1,mirror,out) or not build(p,r,mirror,out) then return false end; out[#out+1]=root; return true end
local out={}; local ok=build(1,n,false,out); if not ok then out={}; ok=build(1,n,true,out) end; if ok then print("YES"); print(table.concat(out," ")) else print("NO") end
