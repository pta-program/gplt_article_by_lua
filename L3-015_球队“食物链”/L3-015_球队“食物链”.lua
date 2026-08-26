-- L3-015 球队“食物链”
-- 实现原理：若两队的任一主客场结果表明 i 战胜 j，则建立有向边 i->j。
-- 从 1 开始按编号递增 DFS 搜索哈密顿回路，首次完整回路即为字典序最小解。

local n = tonumber(io.read("*l"))
local result = {}
for i = 1, n do result[i] = io.read("*l") end
local win = {}
for i = 1, n do
    win[i] = {}
    for j = 1, n do win[i][j] = result[i]:sub(j, j) == "W" or result[j]:sub(i, i) == "L" end
end
local used, path, answer = { [1] = true }, { 1 }, nil
local function dfs(x)
    if #path == n then
        if win[x][1] then answer = {}; for i, v in ipairs(path) do answer[i] = v end; return true end
        return false
    end
    for y = 2, n do
        if not used[y] and win[x][y] then
            used[y], path[#path + 1] = true, y
            if dfs(y) then return true end
            path[#path], used[y] = nil, nil
        end
    end
    return false
end
if dfs(1) then print(table.concat(answer, " ")) else print("No Solution") end
