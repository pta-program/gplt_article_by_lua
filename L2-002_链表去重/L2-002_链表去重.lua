-- 实现原理：按链表顺序访问节点，以键值绝对值判重，分别保存保留链与删除链后重连输出。
local head,n=io.read("*l"):match("(%S+)%s+(%d+)"); n=tonumber(n); local nodes={}; for _=1,n do local a,k,next=io.read("*l"):match("(%S+)%s+(-?%d+)%s+(%S+)"); nodes[a]={key=tonumber(k),next=next} end
local seen,keep,drop={}, {}, {}; local p=head; while p~="-1" do local node=nodes[p]; local list=seen[math.abs(node.key)] and drop or keep; list[#list+1]=p; seen[math.abs(node.key)]=true; p=node.next end
local function output(list) for i,a in ipairs(list) do local nxt=list[i+1] or "-1"; print(a.." "..nodes[a].key.." "..nxt) end end; output(keep); output(drop)
