-- L2-040 哲哲打游戏
-- 实现原理：每个剧情点保存按选择编号排列的下一节点；current 表示当前进度，
-- save[j] 表示第 j 个存档位。三种操作分别更新 current 或 save 即可。

local n, m = io.read("*n"), io.read("*n")
local nextPoint = {}
for i = 1, n do
    local k = io.read("*n")
    nextPoint[i] = {}
    for j = 1, k do nextPoint[i][j] = io.read("*n") end
end
local current, save = 1, {}
for _ = 1, m do
    local op, x = io.read("*n"), io.read("*n")
    if op == 0 then current = nextPoint[current][x]
    elseif op == 1 then save[x] = current; print(current)
    else current = save[x] end
end
print(current)
