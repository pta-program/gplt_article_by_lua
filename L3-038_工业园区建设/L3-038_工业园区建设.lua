-- L3-038 工业园区建设
--
-- 实现原理：对每个仓库位置 i，现有工厂可直接提供一个距离 |i-j|；空地最多
-- 选 M 个新建工厂，也各提供一个距离 |i-j|。把两类候选按距离合并，依次选取
-- 最小的 K 个即可得到该位置的最优总运输距离。
--
-- 注：此写法直接枚举位置，便于对应题意；适用于题目数据规模较小的情形。

local n, m, k = io.read('*n', '*n', '*n')
local s = io.read('*l') or ''
while s:match('^%s*$') do s = io.read('*l') or '' end
local have = {}
for i = 1, n do have[i] = s:sub(i, i) == '1' end

for warehouse = 1, n do
    local old, empty = {}, {}
    for pos = 1, n do
        local d = math.abs(pos - warehouse)
        if have[pos] then old[#old + 1] = d else empty[#empty + 1] = d end
    end
    table.sort(old); table.sort(empty)
    local oi, ei, built, taken, answer = 1, 1, 0, 0, 0
    while taken < k do
        local use_old = oi <= #old and (built >= m or ei > #empty or old[oi] <= empty[ei])
        if use_old then
            answer = answer + old[oi]; oi = oi + 1
        else
            answer = answer + empty[ei]; ei = ei + 1; built = built + 1
        end
        taken = taken + 1
    end
    print(answer)
end
