-- 实现原理：被选中的行或列都不安全；安全格数等于未选行数乘未选列数。
local n, m, q = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)")
n, m, q = tonumber(n), tonumber(m), tonumber(q)
local rows, columns = {}, {}
for _ = 1, q do
    local type_id, index = io.read("*l"):match("(%d+)%s+(%d+)")
    if type_id == "0" then rows[tonumber(index)] = true else columns[tonumber(index)] = true end
end
local row_count, col_count = 0, 0
for _ in pairs(rows) do row_count = row_count + 1 end
for _ in pairs(columns) do col_count = col_count + 1 end
print((n - row_count) * (m - col_count))
