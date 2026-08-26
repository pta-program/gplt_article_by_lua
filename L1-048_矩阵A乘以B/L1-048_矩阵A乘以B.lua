-- 实现原理：仅在 A 的列数等于 B 的行数时，按 C[i][j] = ΣA[i][k]B[k][j] 计算。
local function read_numbers()
    local values = {}
    for token in io.read("*l"):gmatch("-?%d+") do values[#values + 1] = tonumber(token) end
    return values
end
local ra, ca = table.unpack(read_numbers())
local a = {}
for i = 1, ra do a[i] = read_numbers() end
local rb, cb = table.unpack(read_numbers())
local b = {}
for i = 1, rb do b[i] = read_numbers() end
if ca ~= rb then
    print("Error: " .. ca .. " != " .. rb)
else
    print(ra .. " " .. cb)
    for i = 1, ra do
        local row = {}
        for j = 1, cb do
            local sum = 0
            for k = 1, ca do sum = sum + a[i][k] * b[k][j] end
            row[j] = sum
        end
        print(table.concat(row, " "))
    end
end
