-- L3-019 代码排版
--
-- 实现原理：从左到右扫描源程序，分号、花括号是语句边界。花括号维护缩进层数，
-- 控制关键字前的空白统一为题目要求的写法；字符串内部的标点不参与分隔。

local s = io.read("*l") or ""
local indent, out = 0, {}
local function trim(x) return (x:gsub("^%s+", ""):gsub("%s+$", "")) end
local function norm(x)
    x = trim(x)
    x = x:gsub("^(if)%s*%(", "%1 (")
    x = x:gsub("^(for)%s*%(", "%1 (")
    x = x:gsub("^(while)%s*%(", "%1 (")
    return x
end
local function put(x)
    x = norm(x)
    if x ~= "" then out[#out + 1] = string.rep("  ", indent) .. x end
end

-- 字符串中的分号和花括号不作为分隔符处理。
local i, buf, quote = 1, "", nil
while i <= #s do
    local ch = s:sub(i, i)
    if quote then
        buf = buf .. ch
        if ch == "\\" then
            i = i + 1
            if i <= #s then buf = buf .. s:sub(i, i) end
        elseif ch == quote then quote = nil end
    elseif ch == '"' or ch == "'" then
        quote, buf = ch, buf .. ch
    elseif ch == "{" then
        local pre = trim(buf); buf = ""
        if pre ~= "" then put(pre) end
        put("{"); indent = indent + 1
    elseif ch == "}" then
        local pre = trim(buf); buf = ""
        if pre ~= "" then put(pre) end
        indent = math.max(0, indent - 1); put("}")
    elseif ch == ";" then
        put(buf .. ";"); buf = ""
    else
        buf = buf .. ch
    end
    i = i + 1
end
put(buf)
print(table.concat(out, "\n"))
