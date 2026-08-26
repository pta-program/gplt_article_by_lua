-- 实现原理：人数大于 1 的朋友圈中的成员都“有朋友”，记录到集合后过滤查询名单。
local n = tonumber(io.read("*l"))
local social = {}
for _ = 1, n do
    local ids = {}
    for token in io.read("*l"):gmatch("%S+") do ids[#ids + 1] = token end
    if tonumber(ids[1]) > 1 then
        for i = 2, #ids do social[ids[i]] = true end
    end
end
local m = tonumber(io.read("*l"))
local answer, printed = {}, {}
for id in io.read("*l"):gmatch("%S+") do
    if not social[id] and not printed[id] then
        answer[#answer + 1] = id
        printed[id] = true
    end
end
if #answer == 0 then print("No one is handsome") else print(table.concat(answer, " ")) end
