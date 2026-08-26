-- L3-029 还原文件
-- 实现原理：每张纸条的断口高度序列必是完整断口序列中的一个连续片段。
-- 在完整序列中定位每张纸条（必要时同时尝试翻转方向），按起始位置排序即可得到
-- 唯一的拼接顺序。

local n = io.read("*n")
local full = {}; for i = 1, n do full[i] = io.read("*n") end
local m = io.read("*n")
local strips = {}
local function locate(a)
    for start = 1, n - #a + 1 do
        local ok = true
        for j = 1, #a do if full[start + j - 1] ~= a[j] then ok = false; break end end
        if ok then return start end
    end
    return nil
end
for id = 1, m do
    local k, a = io.read("*n"), {}
    for j = 1, k do a[j] = io.read("*n") end
    local pos = locate(a)
    if not pos then
        local rev = {}; for j = #a, 1, -1 do rev[#rev + 1] = a[j] end
        pos = locate(rev)
    end
    strips[id] = { id = id, pos = pos }
end
table.sort(strips, function(a, b) return a.pos < b.pos end)
local out = {}; for i, strip in ipairs(strips) do out[i] = strip.id end
print(table.concat(out, " "))
