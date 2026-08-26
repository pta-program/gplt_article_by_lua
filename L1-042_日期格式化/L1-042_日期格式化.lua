-- 实现原理：按连字符拆分月、日、年，再以 年-月-日 的顺序重组。
local month, day, year = io.read("*l"):match("(%d%d)%-(%d%d)%-(%d%d%d%d)")
print(year .. "-" .. month .. "-" .. day)
