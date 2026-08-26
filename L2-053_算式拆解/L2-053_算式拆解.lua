-- L2-053 算式拆解
-- 实现原理：递归解析完全括号化表达式，后序遍历每个运算节点。
-- 已经计算出的复合子表达式以临时结果代替，因此一行只保留直接数字操作数。

local s, pos = io.read("*l"), 1
local function parse()
    if s:sub(pos, pos) ~= "(" then
        local start = pos
        while s:sub(pos, pos):match("%d") do pos = pos + 1 end
        return { value = s:sub(start, pos - 1) }
    end
    pos = pos + 1
    local left = parse()
    local op = s:sub(pos, pos); pos = pos + 1
    local right = parse()
    pos = pos + 1
    return { left = left, op = op, right = right }
end
local function emit(node)
    if node.value then return end
    emit(node.left); emit(node.right)
    print((node.left.value or "") .. node.op .. (node.right.value or ""))
end
emit(parse())
