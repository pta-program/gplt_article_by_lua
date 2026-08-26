-- 实现原理：统计评委投给 a 的票数，并根据观众票高低套用对应胜出条件。
local pa, pb = io.read("*l"):match("(%d+)%s+(%d+)")
pa, pb = tonumber(pa), tonumber(pb)
local a_votes = 0
for vote in io.read("*l"):gmatch("%d+") do if vote == "0" then a_votes = a_votes + 1 end end
local a_wins = (pa > pb and a_votes >= 1) or (pa < pb and a_votes == 3)
if a_wins then
    print("The winner is a: " .. pa .. " + " .. a_votes)
else
    print("The winner is b: " .. pb .. " + " .. (3 - a_votes))
end
