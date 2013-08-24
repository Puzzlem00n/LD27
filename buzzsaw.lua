local Buzzsaw = class("Buzzsaw")

function Buzzsaw:initialize(x, y)
	self.tx = x
	self.ty = y
	self.l = x*tsize
	self.t = y*tsize
	self.w = tsize
	self.h = tsize
	self.img = love.graphics.newImage("res/Buzzsaw.png")
	self.snd = love.audio.newSource("res/turn.ogg")
	self.spd = .3
	self.rx = x
	self.ry = y
	self.dir = 1
end

function Buzzsaw:update(dt)
	if self.tx == player.tx and self.ty == player.ty then
		player.dead = true
	end
end

function Buzzsaw:draw()
	love.graphics.draw(self.img, self.l, self.t)
end

return Buzzsaw