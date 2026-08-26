-- L2-014 列车调度
-- 实现原理：一条调度轨中的到达编号必须递减，因此最少轨道数等于原序列
-- 的最长严格递增子序列长度。用 patience sorting 的 tails 数组在 O(N log N) 求值。

local n = io.read("*n")
local tails = {}
for _ = 1, n do
    local x = io.read("*n")
    local l, r = 1, #tails
    while l <= r do
        local mid = math.floor((l + r) / 2)
        if tails[mid] >= x then r = mid - 1 else l = mid + 1 end
    end
    tails[l] = x
end
print(#tails)
