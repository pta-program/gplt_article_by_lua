-- 实现原理：并查集维护朋友传递闭包，敌对仅直接边；查询时朋友优先，敌对+共同朋友(c≠a,b且与两者同集合)判OK but...
local data = io.read("*a")
if not data then return end
local nums = {}
for s in data:gmatch("-?%d+") do nums[#nums+1]=tonumber(s) end
if #nums < 3 then return end
local n = nums[1]; local m = nums[2]; local k = nums[3]
local p = {}; for i=1,n do p[i]=i end
local function find(x)
    while p[x] ~= x do p[x]=p[p[x]]; x=p[x] end
    return x
end
local function union(a,b)
    local ra, rb = find(a), find(b)
    if ra ~= rb then p[ra]=rb end
end
local enemy = {}
local idx=4
local relations={}
for i=1,m do
    local a=nums[idx]; local b=nums[idx+1]; local r=nums[idx+2]; idx=idx+3
    if not a or not b or not r then break end
    relations[#relations+1]={a,b,r}
    if r==-1 then enemy[a..":"..b]=true; enemy[b..":"..a]=true end
end
for _,e in ipairs(relations) do if e[3]==1 then union(e[1],e[2]) end end
-- 路径压缩
for i=1,n do find(i) end
for qi=1,k do
    local a=nums[idx]; local b=nums[idx+1]; idx=idx+2
    if not a or not b then break end
    local friends = find(a)==find(b)
    local foes = enemy[a..":"..b] or false
    if friends then
        if foes then
            print("OK but...")
        else
            print("No problem")
        end
    else
        if not foes then
            print("OK")
        else
            -- 敌对且非朋友，检查是否存在共同朋友 c≠a,b 且 c与a同集合且c与b同集合
            -- 该条件在不朋友时恒false，但保留以满足题意修正；同时兼容直接共同朋友检查
            local common=false
            for x=1,n do
                if x~=a and x~=b and find(x)==find(a) and find(x)==find(b) then common=true; break end
            end
            -- 若上述DSU检查恒false，为使逻辑可达，额外检查直接朋友交集（更符合直观共同好友）
            if not common then
                -- 构建直接朋友邻接用于备用检查（若需要）
                -- 此处保持原DSU语义，common保持false则输出No way
            end
            if common then print("OK but...") else print("No way") end
        end
    end
end
