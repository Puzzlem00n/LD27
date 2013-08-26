game = {}

Player = require "player"
BuzzsawV = require "buzzsawv"
BuzzsawH = require "buzzsawh"

function game.load(lvl)
	tsize = 40
	loadMap(lvl)
	peekmode = true
	camspd = 200
	tensec = 10
	gui.group.default.size[1] = 250
	ahh = love.audio.newSource("res/ahh.ogg")
	mine = love.audio.newSource("res/mine.ogg")
	saw = love.audio.newSource("res/saw.ogg")
	peekcount = 1
end

function loadMap(lvl)
	ents = {}
	map = loader.load(lvl..".tmx")
	mainlyr = map.layers["Main"]
	map("Ents").visible = false
	map("BG").visible = false
	cam = gamera.new(0,0,map.width*tsize,map.height*tsize)
	for x, y, tile in map("Ents"):iterate() do
		if tile.properties.player then
			player = Player:new(x,y)
			camx = player.l+20
			camy = player.t+20
		elseif tile.properties.buzzsawv then
			table.insert(ents, BuzzsawV:new(x,y))
		elseif tile.properties.buzzsawh then
			table.insert(ents, BuzzsawH:new(x,y))
		elseif tile.properties.door then
			door = {}
			door.x = x
			door.y = y
		end
	end
end

function game.update(dt)
	for i, ent in pairs(ents) do
		ent:update(dt)
	end
	tween.update(dt)
	if love.keyboard.isDown(" ") then
		tensec = 0
	end
	if peekmode then
		if love.keyboard.isDown("up") then
			camy = camy - camspd*dt
		elseif love.keyboard.isDown("down") then
			camy = camy + camspd*dt
		elseif love.keyboard.isDown("left") then
			camx = camx - camspd*dt
		elseif love.keyboard.isDown("right") then
			camx = camx + camspd*dt
		end
		if camx > map.width*tsize-(love.graphics.getWidth()/2) then
			camx = map.width*tsize-(love.graphics.getWidth()/2)
		end
		if camx < 0+(love.graphics.getWidth()/2) then
			camx = 0+(love.graphics.getWidth()/2)
		end
		if camy > map.height*tsize-(love.graphics.getHeight()/2) then
			camy = map.height*tsize-(love.graphics.getHeight()/2)
		end
		if camy < 0+(love.graphics.getHeight()/2) then
			camy = 0+(love.graphics.getHeight()/2)
		end
		cam:setPosition(camx, camy)
		tensec = tensec - 1*dt
		if tensec <= 0 then
			map("BG").visible = true
			peekmode = false
		end
	else
		player:update(dt)
		cam:setPosition(player.l+20, player.t+20)
	end
end

function game.keypressed(key)
	if key == 'r' and not player.dead and not peekmode then
		player:initialize(player.rx, player.ry)
		tensec = 10
		peekmode = true
		map("BG").visible = false
		camx = player.l+20
		camy = player.t+20
		peekcount = peekcount + 1
	elseif key == "escape" then
		changestate(menu)
	end
end

function game.draw()
	cam:draw(function(l,t,w,h)
		map:setDrawRange(l,t,w,h)
		map:draw()
		player:draw()
		if peekmode then
			for i, ent in pairs(ents) do
				ent:draw()
			end
		end
	end)
	love.graphics.setColor(160,83,83)
	if peekmode then love.graphics.print("Countdown:"..math.ceil(tensec),420,0) end
end