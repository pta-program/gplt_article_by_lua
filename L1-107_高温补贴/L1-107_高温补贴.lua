-- 实现原理：温度达到阈值时，室外工作发 Bu Tie、室内发 Shi Nei；未达到时分别发 Bu Re、Shu Shi。
local t,outdoor,limit=io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)"); t,outdoor,limit=tonumber(t),tonumber(outdoor),tonumber(limit); if t>=limit then print(outdoor==1 and "Bu Tie" or "Shi Nei") else print(outdoor==1 and "Bu Re" or "Shu Shi") end; print(t)
