-- 实现原理：分别检查逗号前、句号前的最后一个拼音是否以 ong 结尾；满足时替换后半句最后三词。
local n = tonumber(io.read("*l"))
for _ = 1, n do
    local line = io.read("*l")
    local left, right = line:match("^(.-),%s*(.-)%.$")
    local left_last = left:match("(%S+)$")
    local right_last = right:match("(%S+)$")
    if left_last:sub(-3) == "ong" and right_last:sub(-3) == "ong" then
        line = line:gsub("%S+%s+%S+%s+%S+%.$", "qiao ben zhong.")
        print(line)
    else
        print("Skipped")
    end
end
