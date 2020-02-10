local tests = {
	5,
	001,
	"stringo",
	function() end,
	false,
	true,
	newproxy(),
	{1},
	{1,2,3,4},
	{1,2,[9]=11},
	{{1}},
	{a=1,b=2,4,{"jej"}},
	{false,{true,{"str",{["bla"]=999}}}},
	{"st\"r"},
}

tests[#tests+1] = {123}
tests[#tests][2] = tests[#tests]

for i,b in pairs(tests) do 
	local ser = serializer(b)
	if ser then
		local tt = unserialize(ser)
		if type(tt) == "table" then
			for a,c in pairs(tt) do 
				io.write(a.."="..tostring(c)..",")
			end	
			io.write(" === "..ser.."\n")
		else 
			print(type(tt), tt, "=", ser)
		end
	else 
		print(i, ser)
	end
end

