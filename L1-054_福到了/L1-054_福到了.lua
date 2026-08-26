-- 实现原理：将网格绕中心旋转 180 度；输出时把原图中的 @ 替换为指定字符。
local symbol, n = io.read("*l"):match("(%S)%s+(%d+)")
n = tonumber(n)
local picture = {}
for i = 1, n do picture[i] = io.read("*l") end
local same = true
for i = 1, n do
    for j = 1, n do
        if picture[i]:sub(j, j) ~= picture[n - i + 1]:sub(n - j + 1, n - j + 1) then same = false end
    end
end
if same then print("bu yong dao le") end
for i = n, 1, -1 do
    local row = {}
    for j = n, 1, -1 do
        local ch = picture[i]:sub(j, j)
        row[#row + 1] = ch == "@" and symbol or " "
    end
    print(table.concat(row))
end
