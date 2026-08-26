-- 实现原理：试除到平方根即可；若不存在整除因子，则该数为素数。
local function is_prime(n)
    if n < 2 then return false end
    if n == 2 then return true end
    if n % 2 == 0 then return false end
    for divisor = 3, math.floor(math.sqrt(n)), 2 do
        if n % divisor == 0 then return false end
    end
    return true
end
local count = tonumber(io.read("*l"))
for _ = 1, count do
    print(is_prime(tonumber(io.read("*l"))) and "Yes" or "No")
end
