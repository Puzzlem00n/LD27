menu = {}

function menu.load()
	title = love.graphics.newImage("res/title.png")
	gui.group.default.size[1] = 182
end

function menu.update(dt)
	gui.Label{pos={209,420}, text = "Select Level"}
	gui.group.push{grow="down", pos={25,450}}
	gui.group.push{grow="right"}
	if gui.Button{text="1"} then
		changestate(game, 1)
	end
	if gui.Button{text="2"} then
		changestate(game, 2)
	end
	if gui.Button{text="3"} then
		changestate(game, 3)
	end
	gui.group.pop{}
	gui.group.push{grow="right"}
	if gui.Button{text="4"} then
		changestate(game, 4)
	end
	if gui.Button{text="5"} then
		changestate(game, 5)
	end
	if gui.Button{text="6"} then
		changestate(game, 6)
	end
	gui.group.pop{}
	gui.group.pop{}
	if gui.Button{pos={209,525}, text = "Instructions"} then
		changestate(instruct)
	end
end

function menu.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function menu.draw()
	love.graphics.draw(title)
end