local Player = class("Player")

function Player:initialize(x, y)
	self.name = "player"
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
	else
		if self.l == self.tx*tsize and self.t == self.ty*tsize then
			self.tx = self.rx
			self.ty = self.ry
			self.l = self.tx*tsize
			self.t = self.ty*tsize
			self.dead = false
		end
	end
end

function Player:move(x,y)
	local tile = mainlyr(self.tx+x, self.ty+y)
	if not tile.properties.block and self.l == self.tx*tsize and self.t == self.ty*tsize then
		self.tx = self.tx + x
		self.ty = self.ty + y
		tween(self.spd, self, {l = self.tx*tsize})
		tween(self.spd, self, {t = self.ty*tsize})
		if tile.properties.kill then
			self.dead = true
		end
	end
end

function Player:draw()
	love.graphics.draw(self.img, self.l, self.t)
end

return Player