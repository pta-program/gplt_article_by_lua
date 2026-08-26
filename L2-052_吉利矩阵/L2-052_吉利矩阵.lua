-- L2-052 吉利矩阵
-- 实现原理：逐行分配每列剩余和。前 N-1 行的每行都是把 L 拆分到 N 个列中，
-- 且不超过列剩余量；最后一行由剩余列和唯一确定。记忆化避免重复状态。

local l, n = io.read("*n"), io.read("*n")
local memo = {}
local function solve(row, rem)
    if row == n then return 1 end
    local key = row .. ":" .. table.concat(rem, ",")
    if memo[key] then return memo[key] end
    local total = 0
    local function distribute(col, left, nextRem)
        if col == n then
            if left <= rem[col] then
                nextRem[col] = rem[col] - left
                total = total + solve(row + 1, nextRem)
            end
            return
        end
        for value = 0, math.min(left, rem[col]) do
            nextRem[col] = rem[col] - value
            distribute(col + 1, left - value, nextRem)
        end
    end
    distribute(1, l, {})
    memo[key] = total
    return total
end
local remaining = {}
for i = 1, n do remaining[i] = l end
print(solve(1, remaining))
