-- 实现原理：读取 24 个时段的指数，根据查询时刻取值并判断是否大于 50。
local mood = {}
for value in io.read("*l"):gmatch("%d+") do mood[#mood + 1] = tonumber(value) end
while true do
    local hour = tonumber(io.read("*l"))
    if hour < 0 or hour > 23 then break end
    print(mood[hour + 1] .. (mood[hour + 1] > 50 and " Yes" or " No"))
end
