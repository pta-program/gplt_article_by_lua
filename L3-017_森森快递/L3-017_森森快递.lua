-- L3-017 森森快递
-- 实现原理：每张订单占用一段连续道路。按右端点升序贪心，尽可能运输该订单，
-- 不会妨碍任何更早结束订单；线段树维护区间剩余容量最小值及区间减法。

local n, q = io.read("*n"), io.read("*n")
local cap = {}; for i = 1, n - 1 do cap[i] = io.read("*n") end
local orders = {}
for i = 1, q do
    local a, b = io.read("*n"), io.read("*n")
    orders[i] = { left = math.min(a, b) + 1, right = math.max(a, b), id = i }
end
table.sort(orders, function(a, b) return a.right ~= b.right and a.right < b.right or a.left < b.left end)
local tree, lazy = {}, {}
local function build(node, l, r)
    if l == r then tree[node] = cap[l]; return end
    local mid = math.floor((l + r) / 2); build(node * 2, l, mid); build(node * 2 + 1, mid + 1, r)
    tree[node] = math.min(tree[node * 2], tree[node * 2 + 1])
end
local function push(node)
    if lazy[node] then
        for _, child in ipairs({ node * 2, node * 2 + 1 }) do tree[child] = tree[child] + lazy[node]; lazy[child] = (lazy[child] or 0) + lazy[node] end
        lazy[node] = nil
    end
end
local function query(node, l, r, a, b)
    if a <= l and r <= b then return tree[node] end
    push(node); local mid, ans = math.floor((l + r) / 2), math.huge
    if a <= mid then ans = math.min(ans, query(node * 2, l, mid, a, b)) end
    if b > mid then ans = math.min(ans, query(node * 2 + 1, mid + 1, r, a, b)) end
    return ans
end
local function add(node, l, r, a, b, value)
    if a <= l and r <= b then tree[node] = tree[node] + value; lazy[node] = (lazy[node] or 0) + value; return end
    push(node); local mid = math.floor((l + r) / 2)
    if a <= mid then add(node * 2, l, mid, a, b, value) end
    if b > mid then add(node * 2 + 1, mid + 1, r, a, b, value) end
    tree[node] = math.min(tree[node * 2], tree[node * 2 + 1])
end
build(1, 1, n - 1)
local answer = 0
for _, order in ipairs(orders) do
    local amount = query(1, 1, n - 1, order.left, order.right)
    if amount > 0 then add(1, 1, n - 1, order.left, order.right, -amount); answer = answer + amount end
end
print(answer)
