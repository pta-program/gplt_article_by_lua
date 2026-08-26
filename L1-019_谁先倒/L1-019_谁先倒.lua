-- 实现原理：每轮仅当一人猜中双方喊数之和时，该人喝一杯；超过酒量即倒下。
local a_limit, b_limit = io.read("*l"):match("(%d+)%s+(%d+)")
a_limit, b_limit = tonumber(a_limit), tonumber(b_limit)
local n = tonumber(io.read("*l"))
local a_drunk, b_drunk = 0, 0
for _ = 1, n do
    local a_call, a_gesture, b_call, b_gesture = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
    a_call, a_gesture = tonumber(a_call), tonumber(a_gesture)
    b_call, b_gesture = tonumber(b_call), tonumber(b_gesture)
    local sum = a_call + b_call
    local a_loses, b_loses = a_gesture == sum, b_gesture == sum
    if a_loses ~= b_loses then
        if a_loses then a_drunk = a_drunk + 1 else b_drunk = b_drunk + 1 end
        if a_drunk > a_limit then print("A"); print(b_drunk); break end
        if b_drunk > b_limit then print("B"); print(a_drunk); break end
    end
end
