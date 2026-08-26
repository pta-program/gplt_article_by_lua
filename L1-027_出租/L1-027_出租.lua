-- 实现原理：收集号码中出现的数字，降序排列为 arr；每一位在 arr 中的位置组成 index。
local phone = io.read("*l")
local present = {}
for digit in phone:gmatch("%d") do present[tonumber(digit)] = true end
local arr = {}
for digit = 9, 0, -1 do if present[digit] then arr[#arr + 1] = digit end end
local position = {}
for i, digit in ipairs(arr) do position[digit] = i - 1 end
local index = {}
for digit in phone:gmatch("%d") do index[#index + 1] = position[tonumber(digit)] end
print("int[] arr = new int[]{" .. table.concat(arr, ",") .. "};")
print("int[] index = new int[]{" .. table.concat(index, ",") .. "};")
