-- L2-050 懂蛇语
-- 实现原理：一句话的“蛇语键”由各个非空单词的首字母串联而成。
-- 用该键映射词典原句，查询时排序并用 | 连接所有同键句子；无键时原样输出。

local function keyOf(line)
    local out = {}
    for word in line:gmatch("%S+") do out[#out + 1] = word:sub(1, 1) end
    return table.concat(out)
end
local n = tonumber(io.read("*l"))
local dict = {}
for _ = 1, n do
    local line = io.read("*l")
    local key = keyOf(line)
    dict[key] = dict[key] or {}
    dict[key][#dict[key] + 1] = line
end
for _, list in pairs(dict) do table.sort(list) end
local q = tonumber(io.read("*l"))
for _ = 1, q do
    local line = io.read("*l")
    local list = dict[keyOf(line)]
    print(list and table.concat(list, "|") or line)
end
