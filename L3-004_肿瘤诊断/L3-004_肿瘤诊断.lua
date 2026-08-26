-- L3-004 肿瘤诊断
-- 实现原理：把值为 1 的体素存入集合，对每个未访问体素进行六方向 BFS。
-- 一个连通块的体素数量即为体积，只有体积不少于阈值 T 的块才计入答案。

local m, n, layers, threshold = io.read("*n"), io.read("*n"), io.read("*n"), io.read("*n")
local filled = {}
local function key(x, y, z) return (z * m + x) * n + y end
for z = 0, layers - 1 do
    for x = 0, m - 1 do
        for y = 0, n - 1 do
            if io.read("*n") == 1 then filled[key(x, y, z)] = { x, y, z } end
        end
    end
end
local answer = 0
for startKey, start in pairs(filled) do
    if filled[startKey] then
        local queue, head, volume = { start }, 1, 0
        filled[startKey] = nil
        while head <= #queue do
            local x, y, z = queue[head][1], queue[head][2], queue[head][3]
            head, volume = head + 1, volume + 1
            for _, d in ipairs({ { 1, 0, 0 }, { -1, 0, 0 }, { 0, 1, 0 }, { 0, -1, 0 }, { 0, 0, 1 }, { 0, 0, -1 } }) do
                local nx, ny, nz = x + d[1], y + d[2], z + d[3]
                if nx >= 0 and nx < m and ny >= 0 and ny < n and nz >= 0 and nz < layers then
                    local k = key(nx, ny, nz)
                    if filled[k] then filled[k] = nil; queue[#queue + 1] = { nx, ny, nz } end
                end
            end
        end
        if volume >= threshold then answer = answer + volume end
    end
end
print(answer)
