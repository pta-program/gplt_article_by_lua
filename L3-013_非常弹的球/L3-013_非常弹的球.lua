-- L3-013 非常弹的球
-- 实现原理：45 度抛射时单次水平射程最大，为 v^2/g。每次弹起后动能乘以
-- (1-p/100)，射程也按同一比例衰减，全部射程是等比级数之和。

local w, p = io.read("*n"), io.read("*n")
local mass, ratio = w / 100, 1 - p / 100
local firstRange = (2000 / mass) / 9.8
local total = firstRange / (1 - ratio)
print(string.format("%.3f", total))
