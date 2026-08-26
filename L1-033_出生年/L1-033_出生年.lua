-- 实现原理：从出生年开始逐年检查四位表示中不同数字的数量，首次恰为 n 时即为答案。
local year, target = io.read("*l"):match("(%d+)%s+(%d+)")
year, target = tonumber(year), tonumber(target)
local function different_digits(value)
    local seen, text = {}, string.format("%04d", value)
    for digit in text:gmatch("%d") do seen[digit] = true end
    local count = 0
    for _ in pairs(seen) do count = count + 1 end
    return count
end
local answer = year
while different_digits(answer) ~= target do answer = answer + 1 end
print((answer - year) .. " " .. string.format("%04d", answer))
