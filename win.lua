win = {}

function win.load()
	winimg = love.graphics.newImage("res/tailedit.png")
end

function win.update(dt)
end

function win.keypressed(key)
	changestate(menu)
end

function win.draw()
	love.graphics.draw(winimg)
	love.graphics.print("Peeks: "..peekcount, 450,0)
end