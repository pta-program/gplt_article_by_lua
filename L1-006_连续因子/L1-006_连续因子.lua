-- 实现原理：连续因子的起点不会超过 sqrt(N)。
-- 从每个起点依次累乘连续整数，积仍能整除 N 时更新最长答案。
local n = tonumber(io.read("*l"))
local best_len, best_start = 1, n
local limit = math.floor(math.sqrt(n))

for start = 2, limit do
    local product, length = 1, 0
    for value = start, limit + 1 do
        product = product * value
        if product > n or n % product ~= 0 then break end
        length = length + 1
        if length > best_len then
            best_len, best_start = length, start
        end
    end
end

local factors = {}
for value = best_start, best_start + best_len - 1 do factors[#factors + 1] = value end
print(best_len)
print(table.concat(factors, "*"))
