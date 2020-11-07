--[[
  This project is forked from Dynodzzo/Lua_INI_Parser.


	Copyright (c) 2012 Carreras Nicolas
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
--]]
--- Lua INI Parser.
-- It has never been that simple to use INI files with Lua.
--@author Dynodzzo

local lini = {}

function lini.load(file)
	file = io.open(file, "r+")
	local data = {}

	for line in file:lines() do
		local p = line:match("^%[([^%[%]]+)%]$")

		if p then
			if tonumber(p) ~= nil then
				t = tonumber(p)
			else
				t = tostring(p)
			end

			data[t] = {}
		end

		local key, value = line:match("^([%w|_]+)%s*=%s*(.+)$")

		if key and value ~= nil then
			if value:find("%s*,%s*") then
				data[t][key] = {}

				for item in value:gmatch("%s*([^,]+)%s*") do
					if tonumber(item) ~= nil then
						item = tonumber(item)
					elseif item == "true" then
						item = true
					elseif item == "false" then
						item = false
					else
						item = tostring(item)
					end

					table.insert(data[t][key], item)
				end
			else
				if tonumber(value) ~= nil then
					value = tonumber(value)
				elseif value == "true" then
					value = true
				elseif value == "false" then
					value = false
				else
					value = tostring(value)
				end

				data[t][key] = value
			end
		end
	end

	file:close()

	return data
end

function lini.save(file, data)
	file = io.open(file, "w+")
	table.sort(data)
	local contents = ""

	for section, param in pairs(data) do
		contents = contents .. ('[%s]\n'):format(section)
		for key, value in pairs(param) do
			if type(data[section][key]) == "table" then
				local hold = {}
				
				for i, v in pairs(data[section][key]) do
					table.insert(hold, tostring(v))
				end

				contents = contents .. ('%s=%s\n'):format(key, table.concat(hold, ", "))
			else
				contents = contents .. ('%s=%s\n'):format(key, tostring(value))
			end
		end
	end

	file:write(contents)
	file:close()
end

return lini
