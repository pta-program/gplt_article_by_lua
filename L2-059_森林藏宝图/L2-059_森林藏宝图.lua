-- 实现原理：树形森林藏宝图，根0出发BFS/DFS求到叶路径最小安全系数瓶颈，取最大值及对应叶编号递增输出
local data = io.read("*a")
if not data then return end
local nums = {}
for s in data:gmatch("-?%d+") do nums[#nums+1]=tonumber(s) end
if #nums==0 then return end
local n = nums[1]
if n == nil or n <= 1 then print(0); print(""); return end
local children = {}
for i=0,n-1 do children[i]={} end
local hasParent = {}
local edgeW = {}
for i=1,n-1 do
    local j = nums[1 + (i-1)*2 +1]
    local s = nums[1 + (i-1)*2 +2]
    if j==nil or s==nil then break end
    -- 节点 i 的前驱是 j
    local node = i
    children[j][#children[j]+1]=node
    hasParent[node]=true
    edgeW[node]=s
end
-- 确定叶子：1..n-1 中无子节点的
local leaves = {}
for i=1,n-1 do
    if #children[i]==0 then leaves[#leaves+1]=i end
end
if #leaves==0 then print(0); print(""); return end
-- BFS/DFS 计算瓶颈
local bottleneck = {}
bottleneck[0]=1e9
-- 使用栈DFS
local stack = {0}
local order = {0}
-- 简易DFS遍历 parent before children
local visited = {[0]=true}
local queue = {0}
local qh=1
while qh <= #queue do
    local u = queue[qh]; qh=qh+1
    for _, v in ipairs(children[u]) do
        local w = edgeW[v] or 0
        local b = bottleneck[u]
        if w < b then b = w end
        bottleneck[v]=b
        queue[#queue+1]=v
    end
end
local maxB = -1
for _, leaf in ipairs(leaves) do
    local b = bottleneck[leaf] or 0
    if b > maxB then maxB = b end
end
print(maxB)
local ans = {}
for _, leaf in ipairs(leaves) do
    if bottleneck[leaf]==maxB then ans[#ans+1]=leaf end
end
table.sort(ans) -- 递增（题面非隐藏为递增）
if #ans>0 then
    local out={}
    for _,v in ipairs(ans) do out[#out+1]=tostring(v) end
    print(table.concat(out," "))
else
    print("")
end
