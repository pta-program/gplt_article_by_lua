-- 实现原理：连续赢 K 次后下一次输出相同招式制造平局；其他轮输出其克制招式。
local win = { ChuiZi = "Bu", JianDao = "ChuiZi", Bu = "JianDao" }
local k = tonumber(io.read("*l"))
local streak = 0
while true do
    local move = io.read("*l")
    if move == "End" then break end
    if streak == k then
        print(move)
        streak = 0
    else
        print(win[move])
        streak = streak + 1
    end
end
