-- L3-001 凑零钱
-- 实现原理：面额排序后，深度优先按“选当前硬币、跳过当前硬币”的顺序搜索，
-- 并记忆 (下标,剩余金额)。首次找到的解即为题目要求的最小字典序解。

local n, target = io.read("*n"), io.read("*n")
local coins = {}
for _ = 1, n do local x = io.read("*n"); if x <= target then coins[#coins + 1] = x end end
table.sort(coins)
local failed, answer = {}, nil
local function dfs(i, remain, chosen)
    if remain == 0 then answer = {}; for j, x in ipairs(chosen) do answer[j] = x end; return true end
    if i > #coins or remain < 0 then return false end
    local key = i .. ":" .. remain
    if failed[key] then return false end
    chosen[#chosen + 1] = coins[i]
    if dfs(i + 1, remain - coins[i], chosen) then return true end
    chosen[#chosen] = nil
    if dfs(i + 1, remain, chosen) then return true end
    failed[key] = true
    return false
end
if dfs(1, target, {}) then print(table.concat(answer, " ")) else print("No Solution") end
