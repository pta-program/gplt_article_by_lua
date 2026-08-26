-- L3-020 至多删三个字符
-- 实现原理：删除 k 个字符等价于求长度 n-k 的不同子序列数。设 F_i[k] 为前 i
-- 个字符中长度 i-k 的不同子序列数。追加字符时，旧子序列和新追加的子序列会
-- 在该字符上一次出现处重复；只需保存每个字母上次出现前的 4 个 F 值即可去重。

local s = io.read("*l")
local previous = { 1, 0, 0, 0 }
local last = {}
for i = 1, #s do
    local ch, current = s:sub(i, i), {}
    local record = last[ch]
    for k = 0, 3 do
        local value = (k >= 1 and previous[k] or 0) + previous[k + 1]
        if record then
            local gap, index = i - record.pos, k - (i - record.pos)
            if index >= 0 then value = value - record.before[index + 1] end
        end
        current[k + 1] = value
    end
    last[ch] = { pos = i, before = { previous[1], previous[2], previous[3], previous[4] } }
    previous = current
end
local answer = previous[1] + previous[2] + previous[3] + previous[4]
print(answer)
