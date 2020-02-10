--By matheus

function serializer(val, carry)
	carry = carry or {}
	local t = type(val)
	if t == "table" then 
		--avoid double ref
		if carry[val] then 
			return "{}"
		end
		carry[val] = true
		local str = ""
		local seq = 1
		for i,b in pairs(val) do 
			
			local vparse = serializer(b,carry)
			
			if vparse then
				local ind = ""
				if seq ~= i then 
					ind = "[\""..tostring(i):gsub('"',"\\\"").."\"]="
				end
				str = str ..ind..vparse..","
			end
			seq = seq +1
		end
		if str:sub(-1,-1) == "," then 
			str = str:sub(1,-2)
		end
		return "{"..str.."}"
	elseif t == 'userdata' or t == 'function' then 
		return nil, "[invalid type]"
	elseif t == 'string' then
		return "\""..val:gsub('"',"\\\"").."\"" 
	end
	return tostring(val), true
end

function unserialize(str)
	local f, err = loadstring("return "..str)
	if not f then 
		error(err)
		return nil
	end
	return f()
end
