-- 实现原理：由后序末尾确定根并在中序中分割左右子树，递归建树后用队列层序遍历。
local n=tonumber(io.read("*l")); local post,inorder={}, {}; for x in io.read("*l"):gmatch("%d+") do post[#post+1]=tonumber(x) end; for x in io.read("*l"):gmatch("%d+") do inorder[#inorder+1]=tonumber(x) end; local pos={}; for i,x in ipairs(inorder) do pos[x]=i end
local function build(pl,pr,il,ir) if pl>pr then return nil end; local root=post[pr]; local k=pos[root]; local left=k-il; return {v=root,l=build(pl,pl+left-1,il,k-1),r=build(pl+left,pr-1,k+1,ir)} end
local root=build(1,n,1,n); local q,out={root},{}; local h=1; while q[h] do local x=q[h]; h=h+1; out[#out+1]=x.v; if x.l then q[#q+1]=x.l end; if x.r then q[#q+1]=x.r end end; print(table.concat(out," "))
