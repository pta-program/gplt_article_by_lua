-- 实现原理：第一个空格前后分别是 A、B；用完整数字匹配和范围判断输入是否合法。
local line = io.read("*l")
local left, right = line:match("^(.-) (.*)$")
local function parse(s)
    if not s:match("^%d+$") then return nil end
    local value = tonumber(s)
    if value < 1 or value > 1000 then return nil end
    return value
end
local a, b = parse(left), parse(right)
local shown_a, shown_b = a or "?", b or "?"
if a and b then
    print(shown_a .. " + " .. shown_b .. " = " .. (a + b))
else
    print(shown_a .. " + " .. shown_b .. " = ?")
end
