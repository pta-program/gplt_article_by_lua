-- 实现原理：每行字符 m 的个数就是一个数字，空行对应数字 0，顺序连接组成电话号码。
local digits={}; while true do local line=io.read("*l"); if not line then break end; digits[#digits+1]=#line end; print(table.concat(digits))
