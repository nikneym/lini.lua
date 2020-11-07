# lini.lua
A lightweight lua INI parser with tables.<br />
*This project is forked from https://github.com/Dynodzzo/Lua_INI_Parser.*

# Usage
Include [lini.lua](https://github.com/nikneym/lini.lua/blob/main/lini.lua) file into your project directory.<br />
Call it using __require__ function.<br />
It will return a table containing read & write functions.<br />

# Docs
* __lini.load(*file_name*)__ : Returns a table containing all the values from the file.<br />
* __lini.save(*file_name*, *data*)__ : Saves the data into the specified file.

# Example
Here is our data:
```lua
local data = {
	screen = {
		title = "Super Meat Boy",
		width = 640,
		height = 480,
	},

	settings = {
		music = 0.7,
		sound = 0.5,
		vsync = false, 
	},

	colors = {
		white = {255, 255, 255},
		red   = {255, 40, 40},
		cyan  = {0, 255, 255},
	},
}
````

All we have to do is import lini.lua and call lini.save:
```lua
lini = require "lini"

lini.save("settings.ini", data)
````

We can open our INI file with lini.load and use stored data:
```lua
local getData = lini.load("settings.ini")

print(getData.screen["title"]) --> Super Meat Boy
print(getData.colors["red"][1]) --> 255

love.graphics.setColor(getData.colors["red"]) --> can easily set color to red.
````
