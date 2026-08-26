-- L2-023 图着色问题
-- 实现原理：去重后颜色数 distinct <= K 且相邻异色即为 Yes。
-- 统计 set[color]=true，若 #set > K 则 No，否则检查每条边两端颜色不等。

local data = io.read("*a")
if not data or data:match("^%s*$") then return end
local nums = {}
for s in data:gmatch("%d+") do nums[#nums+1] = tonumber(s) end
local p = 1
local function nextInt()
    local v = nums[p]
    p = p + 1
    return v
end

local v = nextInt()
local e = nextInt()
local k = nextInt()
if not v then return end

local edges = {}
for i = 1, e do
    edges[i] = { nextInt(), nextInt() }
end

local q = nextInt()
if not q then return end
for _ = 1, q do
    local color = {}
    local set = {}
    local distinct = 0
    for i = 1, v do
        local c = nextInt()
        color[i] = c
        if c ~= nil and not set[c] then
            set[c] = true
            distinct = distinct + 1
        end
    end
    local ok = true
    if distinct > k then
        ok = false
    else
        for _, ed in ipairs(edges) do
            if color[ed[1]] == color[ed[2]] then
                ok = false
                break
            end
        end
    end
    print(ok and "Yes" or "No")
end
