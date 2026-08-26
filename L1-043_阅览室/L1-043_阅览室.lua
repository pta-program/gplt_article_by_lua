-- 实现原理：用书号记录未完成借阅的开始时刻；匹配到 E 时才计入次数与阅读时长。
local days = tonumber(io.read("*l"))
for _ = 1, days do
    local starts, count, total = {}, 0, 0
    while true do
        local id, action, time = io.read("*l"):match("(%d+)%s+(%S+)%s+(%d%d:%d%d)")
        id = tonumber(id)
        if id == 0 then break end
        local hour, minute = time:match("(%d%d):(%d%d)")
        local current = tonumber(hour) * 60 + tonumber(minute)
        if action == "S" then
            starts[id] = current
        elseif starts[id] then
            count = count + 1
            total = total + current - starts[id]
            starts[id] = nil
        end
    end
    local average = count == 0 and 0 or math.floor(total / count + 0.5)
    print(count .. " " .. average)
end
