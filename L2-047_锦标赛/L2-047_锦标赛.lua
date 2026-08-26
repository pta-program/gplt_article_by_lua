-- L2-047 锦标赛
-- 实现原理：对每棵子树求其冠军能力的最小可行值 threshold。
-- 已知一场比赛的败者 L 时，冠军 W 必须不小于 L；递归分配 W 和 L 给两个
-- 子树，选择能满足各自 threshold 的方向，最终即可还原一组叶子能力。

local k = io.read("*n")
local leaves = 2 ^ k
local loser = {}
for round = 1, k do
    local first, count = 2 ^ (k - round), 2 ^ (k - round)
    for j = 0, count - 1 do loser[first + j] = io.read("*n") end
end
local finalWinner = io.read("*n")
local threshold = {}
for i = leaves - 1, 1, -1 do
    local l, left, right = loser[i], threshold[i * 2] or 0, threshold[i * 2 + 1] or 0
    local best = math.huge
    if right <= l then best = math.min(best, math.max(l, left)) end
    if left <= l then best = math.min(best, math.max(l, right)) end
    threshold[i] = best
end
if finalWinner < threshold[1] then
    print("No Solution")
else
    local answer, possible = {}, true
    local function assign(i, winner)
        if i >= leaves then answer[i - leaves + 1] = winner; return end
        local l, left, right = loser[i], threshold[i * 2] or 0, threshold[i * 2 + 1] or 0
        if winner < l then possible = false; return end
        if left <= winner and right <= l then
            assign(i * 2, winner); assign(i * 2 + 1, l)
        elseif right <= winner and left <= l then
            assign(i * 2, l); assign(i * 2 + 1, winner)
        else
            possible = false
        end
    end
    assign(1, finalWinner)
    print(possible and table.concat(answer, " ") or "No Solution")
end
