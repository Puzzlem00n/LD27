win = {}

function win.load()
	win = love.graphics.newImage("res/tailedit.png")
end

function win.update(dt)
end

function win.keypressed(key)
	changestate(menu)
end

function win.draw()
	love.graphics.draw(win)
	love.graphics.print("Peeks: "..peekcount, 450,0)
end