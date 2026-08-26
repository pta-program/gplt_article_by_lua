-- 实现原理：逐位追加数字 1，并按长除法维护余数；余数首次为 0 时得到最短光棍数。
local x = tonumber(io.read("*l"))
local remainder, digits, quotient, started = 0, 0, {}, false
repeat
    local value = remainder * 10 + 1
    local q = value // x
    remainder = value % x
    if q ~= 0 or started then
        quotient[#quotient + 1] = q
        started = true
    end
    digits = digits + 1
until remainder == 0
print(table.concat(quotient) .. " " .. digits)
