-- 实现原理：已离开人数比进入人数多 B-A，因此再进入 B-A 人即可使人数归零。
local a,b=io.read("*l"):match("(%d+)%s+(%d+)"); print(tonumber(b)-tonumber(a))
