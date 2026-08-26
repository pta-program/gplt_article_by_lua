-- L2-012 关于堆的判断
-- 实现原理：按插入顺序维护小顶堆，并记录每个数在堆数组中的下标。
-- 每条英文断言转化为下标间的父子、兄弟或根关系即可判断。

local n, m = io.read("*n"), io.read("*n")
local heap, index = {}, {}

local function push(x)
    local i = #heap + 1
    heap[i] = x
    while i > 1 and heap[math.floor(i / 2)] > x do
        heap[i] = heap[math.floor(i / 2)]
        index[heap[i]] = i
        i = math.floor(i / 2)
    end
    heap[i] = x
    index[x] = i
end

for _ = 1, n do push(io.read("*n")) end
io.read("*l") -- 读掉最后一个数字所在行的换行

for _ = 1, m do
    local s = io.read("*l")
    local a, b = s:match("^(-?%d+) and (-?%d+) are siblings$")
    local ok
    if a then
        a, b = tonumber(a), tonumber(b)
        ok = index[a] and index[b] and math.floor(index[a] / 2) == math.floor(index[b] / 2)
            and index[a] ~= index[b]
    else
        a = s:match("^(-?%d+) is the root$")
        if a then
            ok = index[tonumber(a)] == 1
        else
            a, b = s:match("^(-?%d+) is the parent of (-?%d+)$")
            if a then
                ok = index[tonumber(a)] and index[tonumber(b)]
                    and index[tonumber(b)] == index[tonumber(a)] * 2
                    or (index[tonumber(a)] and index[tonumber(b)]
                        and index[tonumber(b)] == index[tonumber(a)] * 2 + 1)
            else
                a, b = s:match("^(-?%d+) is a child of (-?%d+)$")
                a, b = tonumber(a), tonumber(b)
                ok = index[a] and index[b] and math.floor(index[a] / 2) == index[b]
            end
        end
    end
    print(ok and "T" or "F")
end
