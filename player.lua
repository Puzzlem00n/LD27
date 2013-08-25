local Player = class("Player")

function Player:initialize(x, y)
	self.tx = x
	self.ty = y
	self.l = x*tsize
	self.t = y*tsize
	self.w = tsize
	self.h = tsize
	self.img = love.graphics.newImage("res/player.png")
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
		elseif love.keyboard.isDown("down") then
			self:move(0,1)
		elseif love.keyboard.isDown("left") then
			self:move(-1,0)
		elseif love.keyboard.isDown("right") then
			self:move(1,0)
		end
		if (self.tx == door.x or self.tx == door.x-1) and self.ty == door.y  then
			gui.Label{text="WINNER"}
		end
	else
		if self.l == self.tx*tsize and self.t == self.ty*tsize then
			gui.group.push{pos={180,275}, grow="right"}
			if gui.Button{text="Peek Again"} then
				self:initialize(self.rx, self.ry)
				tensec = 10
				peekmode = true
				map("Main").visible = true
				camx = player.l+20
				camy = player.t+20
			end
			if gui.Button{text="Again, no Peeking"} then
				self:initialize(self.rx, self.ry)
			end
			gui.group.pop{}
		end
	end
end

function Player:move(x,y)
	local tile = mainlyr(self.tx+x, self.ty+y)
	local lasttile = mainlyr(self.tx, self.ty)
	if tile and not tile.properties.block and self.l == self.tx*tsize and self.t == self.ty*tsize then
		if lasttile.properties.crumble then
			table.insert(self.crum, {x=self.tx, y=self.ty})
			--add crumble sfx
		end
		self.tx = self.tx + x
		self.ty = self.ty + y
		tween(self.spd, self, {l = self.tx*tsize})
		tween(self.spd, self, {t = self.ty*tsize})
		if tile.properties.kill then
			self.dead = true
			--add mine sfx
		end
		for i, crumbs in pairs(self.crum) do
			if crumbs.x == self.tx and crumbs.y == self.ty then
				self.dead = true
				--add fall sfx
			end
		end
	end
end

function Player:draw()
	love.graphics.draw(self.img, self.l, self.t)
end

return Player