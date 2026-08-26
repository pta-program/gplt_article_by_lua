-- 实现原理：目标为所有猜测总和除以人数再除以 2 的整数部分；选与其距离最小的人。
local n = tonumber(io.read("*l"))
local players, sum = {}, 0
for i = 1, n do
    local name, value = io.read("*l"):match("(%S+)%s+(%d+)")
    players[i] = { name = name, value = tonumber(value) }
    sum = sum + players[i].value
end
local target, winner, distance = (sum // n) // 2, nil, math.huge
for _, player in ipairs(players) do
    local d = math.abs(player.value - target)
    if d < distance then winner, distance = player.name, d end
end
print(target .. " " .. winner)
