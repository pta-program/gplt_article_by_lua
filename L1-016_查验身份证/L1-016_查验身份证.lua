-- 实现原理：按给定权重计算前 17 位加权和，模 11 后查询校验码表。
local weights = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2}
local checks = {"1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"}
local n = tonumber(io.read("*l"))
local all_valid = true
for _ = 1, n do
    local id = io.read("*l")
    local sum, valid = 0, true
    for i = 1, 17 do
        local digit = tonumber(id:sub(i, i))
        if not digit then valid = false break end
        sum = sum + digit * weights[i]
    end
    if valid and checks[sum % 11 + 1] ~= id:sub(18, 18) then valid = false end
    if not valid then print(id); all_valid = false end
end
if all_valid then print("All passed") end
