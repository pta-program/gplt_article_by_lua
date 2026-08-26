-- L3-002 特殊堆栈
-- 实现原理：一个数组维护真实栈，Fenwick 树维护所有键值的出现次数。
-- Fenwick 前缀和的二分查找能在 O(log MAX) 找到第 k 小数，从而得到中位数。

local maxKey, bit, stack = 100000, {}, {}
local function add(i, delta) while i <= maxKey do bit[i] = (bit[i] or 0) + delta; i = i + (i & -i) end end
local function kth(k)
    local idx, step = 0, 1
    while step * 2 <= maxKey do step = step * 2 end
    while step > 0 do
        local nextIndex = idx + step
        if nextIndex <= maxKey and (bit[nextIndex] or 0) < k then k = k - (bit[nextIndex] or 0); idx = nextIndex end
        step = math.floor(step / 2)
    end
    return idx + 1
end
local q = tonumber(io.read("*l"))
for _ = 1, q do
    local line = io.read("*l")
    local x = line:match("Push (%d+)")
    if x then x = tonumber(x); stack[#stack + 1] = x; add(x, 1)
    elseif #stack == 0 then print("Invalid")
    elseif line == "Pop" then local v = stack[#stack]; stack[#stack] = nil; add(v, -1); print(v)
    else print(kth(math.floor((#stack + 1) / 2))) end
end
