instruct = {}

function instruct.load()
	instruct = love.graphics.newImage("res/instruc.png")
end

function instruct.update(dt)
end

function instruct.keypressed(key)
	if key == "escape" then
		changestate(menu)
	end
end

function instruct.draw()
	love.graphics.draw(instruct)
end