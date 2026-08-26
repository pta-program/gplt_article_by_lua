-- L2-022 重排链表
-- 实现原理：先沿首地址遍历出真实链表节点，再从末端、首端交替取节点，
-- 得到 Ln,L1,Ln-1,L2... 的新顺序；输出时由相邻元素确定 Next 地址。

local data = io.read("*a")
local tokens = {}
for tok in data:gmatch("%S+") do tokens[#tokens+1] = tok end
local pos = 1
local function nextTok() pos = pos + 1; return tokens[pos-1] end
local function nextInt() local t = nextTok(); return t and tonumber(t) end
local head = nextTok()
local n = tonumber(nextTok())
local nodes = {}
for _ = 1, n do
    local addr = nextTok()
    local dataVal = tonumber(nextTok())
    local nextAddr = nextTok()
    nodes[addr] = { addr = addr, data = dataVal, nextAddr = nextAddr }
end

local list, p = {}, head
while p ~= "-1" do
    list[#list + 1] = nodes[p]
    p = nodes[p].nextAddr
end
local order, l, r = {}, 1, #list
while l <= r do
    order[#order + 1] = list[r]
    r = r - 1
    if l <= r then order[#order + 1] = list[l]; l = l + 1 end
end
for i, node in ipairs(order) do
    local nextAddr = order[i + 1] and order[i + 1].addr or "-1"
    print(node.addr .. " " .. node.data .. " " .. nextAddr)
end
