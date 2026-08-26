-- L2-017 人以群分
-- 实现原理：排序后，人数尽量接近时应让较小的一半归入 introverted，
-- 较大的一半归入 outgoing。各自求和即可得到人数差和总值差。

local n = io.read("*n")
local a = {}
for i = 1, n do a[i] = io.read("*n") end
table.sort(a)
local intro = math.floor(n / 2)
local left, right = 0, 0
for i = 1, intro do left = left + a[i] end
for i = intro + 1, n do right = right + a[i] end
print("Outgoing #: " .. (n - intro))
print("Introverted #: " .. intro)
print("Diff = " .. (right - left))
