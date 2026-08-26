-- L2-054 三点共线
-- 实现原理：枚举任意三点，用叉积 (B-A)x(C-A)=0 判断共线；以坐标三元组去重，
-- 再按三点的字典序输出。若无三点共线则输出 -1。

local n = io.read("*n")
local points, exists = {}, {}
for _ = 1, n do
    local x, y = io.read("*n"), io.read("*n")
    local key = x .. "," .. y
    if not exists[key] then exists[key] = true; points[#points + 1] = { x, y } end
end
n = #points
local lines, used = {}, {}
for i = 1, n - 2 do for j = i + 1, n - 1 do for k = j + 1, n do
    local a, b, c = points[i], points[j], points[k]
    if (b[1] - a[1]) * (c[2] - a[2]) == (b[2] - a[2]) * (c[1] - a[1]) then
        local p = { a, b, c }
        table.sort(p, function(x, y) return x[2] ~= y[2] and x[2] < y[2] or x[1] < y[1] end)
        local key = p[1][1] .. "," .. p[1][2] .. ";" .. p[2][1] .. "," .. p[2][2] .. ";" .. p[3][1] .. "," .. p[3][2]
        if not used[key] then used[key] = true; lines[#lines + 1] = p end
    end
end end end
table.sort(lines, function(a, b)
    for i = 1, 3 do
        if a[i][1] ~= b[i][1] then return a[i][1] < b[i][1] end
        if a[i][2] ~= b[i][2] then return a[i][2] < b[i][2] end
    end
    return false
end)
if #lines == 0 then print("-1") else
    for _, line in ipairs(lines) do
        print(string.format("[%d, %d] [%d, %d] [%d, %d]", line[1][1], line[1][2], line[2][1], line[2][2], line[3][1], line[3][2]))
    end
end
