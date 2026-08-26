-- 实现原理：每次按 a/b + c/d = (ad+bc)/(bd) 合并分数，并用最大公约数约分。
-- 最后用整数除法拆出整数部分和真分数部分。
local function gcd(a, b)
    a, b = math.abs(a), math.abs(b)
    while b ~= 0 do a, b = b, a % b end
    return a
end

local function reduce(num, den)
    if den < 0 then num, den = -num, -den end
    local g = gcd(num, den)
    return num // g, den // g
end

local n = tonumber(io.read("*l"))
local line = io.read("*l")
local numerator, denominator = 0, 1
for token in line:gmatch("%S+") do
    local a, b = token:match("(-?%d+)/(%d+)")
    a, b = tonumber(a), tonumber(b)
    numerator = numerator * b + a * denominator
    denominator = denominator * b
    numerator, denominator = reduce(numerator, denominator)
end

local sign = numerator < 0 and "-" or ""
local absolute = math.abs(numerator)
local integer = absolute // denominator
local remainder = absolute % denominator
if remainder == 0 then
    print(sign .. integer)
elseif integer == 0 then
    print(sign .. remainder .. "/" .. denominator)
else
    print(sign .. integer .. " " .. remainder .. "/" .. denominator)
end
