-- L2-018 多项式A除以B
-- 实现原理：每次用当前余式最高项除以除式最高项，得到商的一项，
-- 再用该项乘除式并从余式中相减。最高次数下降，直至不能再除。

local function readPolynomial()
    local n = io.read("*n")
    local p = {}
    for _ = 1, n do
        local e, c = io.read("*n"), io.read("*n")
        p[e] = (p[e] or 0) + c
    end
    return p
end

local a, b = readPolynomial(), readPolynomial()
local function degree(p)
    local best = nil
    for e, c in pairs(p) do
        if math.abs(c) > 1e-9 and (not best or e > best) then best = e end
    end
    return best
end

local quotient = {}
local db = degree(b)
while degree(a) and degree(a) >= db do
    local da = degree(a)
    local e, c = da - db, a[da] / b[db]
    quotient[e] = (quotient[e] or 0) + c
    for be, bc in pairs(b) do
        local target = be + e
        a[target] = (a[target] or 0) - c * bc
        if math.abs(a[target]) < 1e-9 then a[target] = nil end
    end
end

local function output(p)
    local terms = {}
    for e, c in pairs(p) do
        -- 输出保留一位小数；四舍五入后为 0 的项不应计入多项式。
        if tonumber(string.format("%.1f", c)) ~= 0 then
            terms[#terms + 1] = { e = e, c = c }
        end
    end
    table.sort(terms, function(x, y) return x.e > y.e end)
    local out = { #terms }
    for _, term in ipairs(terms) do
        out[#out + 1] = term.e
        out[#out + 1] = string.format("%.1f", term.c)
    end
    print(table.concat(out, " "))
end

output(quotient)
output(a)
