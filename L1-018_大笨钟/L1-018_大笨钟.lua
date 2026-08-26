-- 实现原理：中午 12:00 前（含）不报时；之后报“下一个整点”的 12 小时制次数。
local time = io.read("*l")
local hour, minute = time:match("(%d%d):(%d%d)")
hour, minute = tonumber(hour), tonumber(minute)
if hour < 12 or (hour == 12 and minute == 0) then
    print("Only " .. time .. ".  Too early to Dang.")
else
    local times = hour - 12 + (minute > 0 and 1 or 0)
    print(string.rep("Dang", times))
end
