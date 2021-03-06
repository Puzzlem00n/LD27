local Player = class("Player")

function Player:initialize(x, y)
	self.tx = x
	self.ty = y
	self.l = x*tsize
	self.t = y*tsize
	self.w = tsize
	self.h = tsize
	self.img = love.graphics.newImage("res/player.png")
	self.dwn = love.graphics.newQuad(0,0,40,40,160,40)
	self.up = love.graphics.newQuad(40,0,40,40,160,40)
	self.lft = love.graphics.newQuad(80,0,40,40,160,40)
	self.rgt = love.graphics.newQuad(120,0,40,40,160,40)
	self.anim = self.dwn
	self.spd = .3
	self.rx = x
	self.ry = y
	self.dead = false
	self.crum = {}
end

function Player:update(dt)
	if not self.dead then
		if love.keyboard.isDown("up") then
			self:move(0,-1)
			self.anim = self.up
		elseif love.keyboard.isDown("down") then
			self:move(0,1)
			self.anim = self.dwn
		elseif love.keyboard.isDown("left") then
			self:move(-1,0)
			self.anim = self.lft
		elseif love.keyboard.isDown("right") then
			self:move(1,0)
			self.anim = self.rgt
		end
		if (self.tx == door.x or self.tx == door.x-1) and self.ty == door.y  then
			changestate(win)
		end
	else
		gui.group.push{pos={50,275}, grow="right"}
		if gui.Button{text="Peek Again"} then
			self:initialize(self.rx, self.ry)
			tensec = 10
			peekmode = true
			map("BG").visible = false
			camx = player.l+20
			camy = player.t+20
			peekcount = peekcount + 1
		end
		if gui.Button{text="Again, no Peeking"} then
			self:initialize(self.rx, self.ry)
		end
		gui.group.pop{}
	end
end

function Player:move(x,y)
	local tile = mainlyr(self.tx+x, self.ty+y)
	local lasttile = mainlyr(self.tx, self.ty)
	if tile and not tile.properties.block and self.l == self.tx*tsize and self.t == self.ty*tsize then
		if lasttile.properties.crumble then
			table.insert(self.crum, {x=self.tx, y=self.ty})
		end
		self.tx = self.tx + x
		self.ty = self.ty + y
		tween(self.spd, self, {l = self.tx*tsize})
		tween(self.spd, self, {t = self.ty*tsize})
		if tile.properties.kill then
			self.dead = true
			love.audio.play(mine)
		end
		for i, crumbs in pairs(self.crum) do
			if crumbs.x == self.tx and crumbs.y == self.ty then
				self.dead = true
				love.audio.play(ahh)
			end
		end
	end
end

function Player:draw()
	if not self.dead then love.graphics.drawq(self.img, self.anim, self.l, self.t) end
end

return Player