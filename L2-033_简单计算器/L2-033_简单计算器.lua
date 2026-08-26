-- L2-033 简单计算器
-- 实现原理：数字和运算符按给定顺序压入两个栈，随后按题意依次弹出。
-- 因此每次计算的是“后弹出的数 op 先弹出的数”，除法用 modf 截去小数部分。

local __data = io.read("*a") or ""
local __toks = {}
for tok in __data:gmatch("%S+") do __toks[#__toks + 1] = tok end
local __idx = 1
local function __next_tok() local t = __toks[__idx]; __idx = __idx + 1; return t end
local function __next_num() local t = __next_tok(); return t and tonumber(t) end
local n = __next_num()
local nums, ops = {}, {}
for i = 1, n do nums[i] = __next_num() end
for i = 1, n - 1 do ops[i] = __next_tok() end
while #ops > 0 do
    local n1, n2 = nums[#nums], nums[#nums - 1]
    nums[#nums], nums[#nums - 1] = nil, nil
    local op = ops[#ops]
    ops[#ops] = nil
    local value
    if op == "+" then value = n2 + n1
    elseif op == "-" then value = n2 - n1
    elseif op == "*" then value = n2 * n1
    else
        if n1 == 0 then print("ERROR: " .. n2 .. "/0"); os.exit() end
        value = math.modf(n2 / n1)
    end
    nums[#nums + 1] = value
end
print(nums[1])
