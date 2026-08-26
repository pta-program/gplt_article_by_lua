-- 实现原理：0 是唯一被遮住的数字，先用 1~9 中缺失的数补全，再按所选方向求和查奖金表。
local grid, used = {}, {}
for i = 1, 3 do
    grid[i] = {}
    for token in io.read("*l"):gmatch("%d+") do
        local value = tonumber(token)
        grid[i][#grid[i] + 1] = value
        if value ~= 0 then used[value] = true end
    end
end
local missing
for value = 1, 9 do if not used[value] then missing = value end end
for i = 1, 3 do for j = 1, 3 do if grid[i][j] == 0 then grid[i][j] = missing end end end
for _ = 1, 3 do
    local x, y = io.read("*l"):match("(%d+)%s+(%d+)")
    print(grid[tonumber(x)][tonumber(y)])
end
local direction = tonumber(io.read("*l"))
local lines = {
    {grid[1][1], grid[1][2], grid[1][3]}, {grid[2][1], grid[2][2], grid[2][3]}, {grid[3][1], grid[3][2], grid[3][3]},
    {grid[1][1], grid[2][1], grid[3][1]}, {grid[1][2], grid[2][2], grid[3][2]}, {grid[1][3], grid[2][3], grid[3][3]},
    {grid[1][1], grid[2][2], grid[3][3]}, {grid[1][3], grid[2][2], grid[3][1]}
}
local sum = lines[direction][1] + lines[direction][2] + lines[direction][3]
local prize = {[6]=10000,[7]=36,[8]=720,[9]=360,[10]=80,[11]=252,[12]=108,[13]=72,[14]=54,[15]=180,[16]=72,[17]=180,[18]=119,[19]=36,[20]=306,[21]=1080,[22]=144,[23]=1800,[24]=3600}
print(prize[sum])
