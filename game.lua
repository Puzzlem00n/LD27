game = {}

Player = require "player"

function game.load()
	tsize = 40
	loadMap(1)
	peekmode = true
	camspd = 200
	tensec = 10
end

function loadMap(lvl)
	map = loader.load("testmap.tmx")
	mainlyr = map.layers["Main"]
	map("Ents").visible = false
	cam = gamera.new(0,0,map.width*tsize,map.height*tsize)
	for x, y, tile in map("Ents"):iterate() do
		if tile.properties.player then
			player = Player:new(x,y)
			camx = player.l
			camy = player.t
		end
	end
end

function game.update(dt)
	
	tween.update(dt)
	if peekmode then
		if love.keyboard.isDown("up") then
			camy = camy - camspd*dt
			if camy < 0+(love.graphics.getHeight()/2) then
				camy = 0+(love.graphics.getHeight()/2)
			end
		elseif love.keyboard.isDown("down") then
			camy = camy + camspd*dt
			if camy > map.height*tsize-(love.graphics.getHeight()/2) then
				camy = map.height*tsize-(love.graphics.getHeight()/2)
			end
		elseif love.keyboard.isDown("left") then
			camx = camx - camspd*dt
			if camx < 0+(love.graphics.getWidth()/2) then
				camx = 0+(love.graphics.getWidth()/2)
			end
		elseif love.keyboard.isDown("right") then
			camx = camx + camspd*dt
			if camx > map.width*tsize-(love.graphics.getWidth()/2) then
				camx = map.width*tsize-(love.graphics.getWidth()/2)
			end
		end
		cam:setPosition(camx, camy)
		tensec = tensec - 1*dt
		if tensec <= 0 then map("Main").visible = false peekmode = false  end
	else
		player:update(dt)
		cam:setPosition(player.l+20, player.t+20)
	end
end

function game.draw()
	cam:draw(function(l,t,w,h)
		map:setDrawRange(l,t,w,h)
		map:draw()
		player:draw()
	end)
	love.graphics.setColor(125,125,125)
	if peekmode then love.graphics.print(math.ceil(tensec),0,0) end
end