-- 实现原理：红绿灯且前方无人时才提示；行动由红灯决定停止，其余情况前进。
local a,b=io.read("*l"):match("(%d+)%s+(%d+)"); a,b=tonumber(a),tonumber(b); if b==1 or a==2 then print("-") elseif a==0 then print("biii") else print("dudu") end; print(a==0 and "stop" or "move")
