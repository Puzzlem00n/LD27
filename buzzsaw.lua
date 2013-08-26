local Buzzsaw = class("Buzzsaw")

function Buzzsaw:initialize(x, y)
	self.tx = x
	self.ty = y
	self.l = x*tsize
	self.t = y*tsize
	self.w = tsize
	self.h = tsize
	self.img = love.graphics.newImage("res/buzzsaw.png")
	local g = anim8.newGrid(80,80,160,80)
	self.anim = anim8.newAnimation(g('1-2',1), 0.15)
	self.snd = love.audio.newSource("res/turn.ogg")
	self.spd = .3
	self.dir = 1
end

function Buzzsaw:update(dt)
	if self.tx == player.tx and self.ty == player.ty then
		player.dead = true
		love.audio.play(saw)
		player.tx = 0
		player.ty = 0
	end
	self.anim:update(dt)
end

function Buzzsaw:draw()
	self.anim:draw(self.img,self.l,self.t,0,.5,.5)
end

return Buzzsaw