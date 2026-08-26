-- 实现原理：原串长度不足 N 时在左侧补字符，否则截取其最右侧 N 个字符。
local n, pad = io.read("*l"):match("(%d+)%s+(%S)")
n = tonumber(n)
local s = io.read("*l")
if #s < n then
    print(string.rep(pad, n - #s) .. s)
else
    print(s:sub(#s - n + 1))
end
