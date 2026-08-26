-- L2-029 特立独行的幸福
-- 实现原理：对区间内每个数模拟各位平方和，检测到 1 即为幸福数并记录步数。
-- 若某幸福数出现在另一幸福数的迭代链中，它就依附于后者；未被依附者才输出。

local a, b = io.read("*n"), io.read("*n")
local function nextValue(x)
    local sum = 0
    while x > 0 do local d = x % 10; sum = sum + d * d; x = math.floor(x / 10) end
    return sum
end
local function happinessSteps(x)
    local seen, steps = {}, 0
    while x ~= 1 and not seen[x] do
        seen[x] = true
        x = nextValue(x)
        steps = steps + 1
    end
    return x == 1 and steps or nil
end
local function isPrime(x)
    if x < 2 then return false end
    for d = 2, math.floor(math.sqrt(x)) do if x % d == 0 then return false end end
    return true
end

local steps, attached = {}, {}
for x = a, b do steps[x] = happinessSteps(x) end
for x = a, b do
    if steps[x] then
        local y = nextValue(x)
        while y ~= 1 do
            if y >= a and y <= b then attached[y] = true end
            y = nextValue(y)
        end
    end
end
local found = false
for x = a, b do
    if steps[x] and not attached[x] then
        local value = steps[x]
        if isPrime(x) then value = value * 2 end
        print(x .. " " .. value)
        found = true
    end
end
if not found then print("SAD") end
