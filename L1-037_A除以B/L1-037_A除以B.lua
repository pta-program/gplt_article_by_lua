-- 实现原理：按分母的符号决定展示格式；分母为 0 时不计算商而输出 Error。
local a, b = io.read("*l"):match("(-?%d+)%s+(-?%d+)")
a, b = tonumber(a), tonumber(b)
local divisor = b < 0 and "(" .. b .. ")" or tostring(b)
if b == 0 then
    print(a .. "/" .. divisor .. "=Error")
else
    print(a .. "/" .. divisor .. "=" .. string.format("%.2f", a / b))
end
