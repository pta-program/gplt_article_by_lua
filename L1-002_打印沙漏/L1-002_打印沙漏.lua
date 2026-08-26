-- 实现原理：高度为 h 的沙漏共使用 2*h*h-1 个字符。
-- 逐步增加 h，找到不超过 N 的最大值；再按奇数宽度打印上下两半。
local n, ch = io.read("*n"), io.read("*l"):match("%S")
local h = 1
while 2 * (h + 1) * (h + 1) - 1 <= n do h = h + 1 end

for row = h, 1, -1 do
    print(string.rep(" ", h - row) .. string.rep(ch, 2 * row - 1))
end
for row = 2, h do
    print(string.rep(" ", h - row) .. string.rep(ch, 2 * row - 1))
end
print(n - (2 * h * h - 1))
