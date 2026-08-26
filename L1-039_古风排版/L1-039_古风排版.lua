-- 实现原理：文本从右侧列开始自上而下填入；未填满的位置保留为空格后逐行打印。
local rows = tonumber(io.read("*l"))
local text = io.read("*l")
local columns = math.ceil(#text / rows)
local page = {}
for r = 1, rows do
    page[r] = {}
    for c = 1, columns do page[r][c] = " " end
end
for i = 1, #text do
    local column = columns - (i - 1) // rows
    local row = (i - 1) % rows + 1
    page[row][column] = text:sub(i, i)
end
for r = 1, rows do print(table.concat(page[r])) end
