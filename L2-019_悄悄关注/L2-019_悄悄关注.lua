-- L2-019 悄悄关注
-- 实现原理：先用集合记录已关注用户，再统计每个出现用户的点赞总数和次数。
-- 平均点赞数之上的未关注用户为候选，按昵称字典序输出。

local line = io.read("*l")
local followed = {}
for id in line:gmatch("%S+") do
    if id ~= line:match("^%S+") then followed[id] = true end
end
-- 首个字段是关注数；重新按字段处理可避免把它作为用户 ID。
followed = {}
local first = true
for id in line:gmatch("%S+") do
    if first then first = false else followed[id] = true end
end

local rest = io.read("*a") or ""
local __toks = {}
for tok in rest:gmatch("%S+") do __toks[#__toks + 1] = tok end
local __idx = 1
local function __next_tok() local t = __toks[__idx]; __idx = __idx + 1; return t end
local function __next_num() local t = __next_tok(); return t and tonumber(t) end
local m = __next_num()
local total, sum, count = 0, {}, {}
for _ = 1, m do
    local id = __next_tok()
    local likes = __next_num()
    total = total + likes
    sum[id] = (sum[id] or 0) + likes
    count[id] = (count[id] or 0) + 1
end

local answer = {}
for id, value in pairs(sum) do
    if not followed[id] and value / count[id] > total / m then answer[#answer + 1] = id end
end
table.sort(answer)
if #answer == 0 then print("Bing Meiyou") else print(table.concat(answer, "\n")) end
