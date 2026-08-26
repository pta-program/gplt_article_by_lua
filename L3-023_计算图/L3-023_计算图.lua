-- L3-023 计算图
-- 实现原理：节点按输入顺序计算前向数值，并保存操作数编号。输出节点的梯度置为
-- 1 后逆序传播局部导数，即可一次反向自动微分得到所有输入变量的偏导数。

local n = io.read("*n")
local typ, left, right, value, grad, variables, outDegree = {}, {}, {}, {}, {}, {}, {}
for i = 0, n - 1 do
    typ[i] = io.read("*n")
    if typ[i] == 0 then value[i] = io.read("*n"); variables[#variables + 1] = i
    elseif typ[i] <= 3 then
        left[i], right[i] = io.read("*n"), io.read("*n")
        local a, b = value[left[i]], value[right[i]]
        if typ[i] == 1 then value[i] = a + b elseif typ[i] == 2 then value[i] = a - b else value[i] = a * b end
        outDegree[left[i]] = (outDegree[left[i]] or 0) + 1; outDegree[right[i]] = (outDegree[right[i]] or 0) + 1
    else
        left[i] = io.read("*n")
        local a = value[left[i]]
        if typ[i] == 4 then value[i] = math.exp(a) elseif typ[i] == 5 then value[i] = math.log(a) else value[i] = math.sin(a) end
        outDegree[left[i]] = (outDegree[left[i]] or 0) + 1
    end
end
local output
for i = 0, n - 1 do if not outDegree[i] then output = i; break end end
grad[output] = 1
for i = n - 1, 0, -1 do
    local g = grad[i] or 0
    if typ[i] == 1 then grad[left[i]] = (grad[left[i]] or 0) + g; grad[right[i]] = (grad[right[i]] or 0) + g
    elseif typ[i] == 2 then grad[left[i]] = (grad[left[i]] or 0) + g; grad[right[i]] = (grad[right[i]] or 0) - g
    elseif typ[i] == 3 then grad[left[i]] = (grad[left[i]] or 0) + g * value[right[i]]; grad[right[i]] = (grad[right[i]] or 0) + g * value[left[i]]
    elseif typ[i] == 4 then grad[left[i]] = (grad[left[i]] or 0) + g * value[i]
    elseif typ[i] == 5 then grad[left[i]] = (grad[left[i]] or 0) + g / value[left[i]]
    elseif typ[i] == 6 then grad[left[i]] = (grad[left[i]] or 0) + g * math.cos(value[left[i]]) end
end
local out = {}
for i, v in ipairs(variables) do out[i] = string.format("%.3f", grad[v] or 0) end
print(string.format("%.3f", value[output]))
print(table.concat(out, " "))
