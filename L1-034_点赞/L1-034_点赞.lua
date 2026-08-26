-- 实现原理：累加每个标签的出现次数，更新时将“次数更大、编号更大”作为优先条件。
local n = tonumber(io.read("*l"))
local count, best_id, best_count = {}, 0, 0
for _ = 1, n do
    local tags = {}
    for value in io.read("*l"):gmatch("%d+") do tags[#tags + 1] = tonumber(value) end
    for i = 2, #tags do
        local id = tags[i]
        count[id] = (count[id] or 0) + 1
        if count[id] > best_count or (count[id] == best_count and id > best_id) then
            best_id, best_count = id, count[id]
        end
    end
end
print(best_id .. " " .. best_count)
