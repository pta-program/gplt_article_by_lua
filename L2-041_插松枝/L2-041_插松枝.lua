-- L2-041 插松枝
-- 实现原理：小盒子是栈、推送器是按给定顺序取物的队列。
-- 每根松枝依次插入不大于前一片的松针；不能继续时输出当前成品并重新开始。

local n, boxLimit, branchLimit = io.read("*n"), io.read("*n"), io.read("*n")
local feeder = {}
for i = 1, n do feeder[i] = io.read("*n") end
local box, pos = {}, 1
while pos <= n or #box > 0 do
    local branch = {}
    if #box > 0 then
        branch[1] = box[#box]; box[#box] = nil
    else
        branch[1] = feeder[pos]; pos = pos + 1
    end
    while #branch < branchLimit do
        local last = branch[#branch]
        if #box > 0 and box[#box] <= last then
            branch[#branch + 1] = box[#box]; box[#box] = nil
        elseif pos <= n then
            local x = feeder[pos]
            if x <= last then
                branch[#branch + 1] = x; pos = pos + 1
            elseif #box < boxLimit then
                box[#box + 1] = x; pos = pos + 1
            else
                -- 推送器上的这片松针压回去，留给下一根松枝作为候选。
                break
            end
        else
            break
        end
    end
    print(table.concat(branch, " "))
end
