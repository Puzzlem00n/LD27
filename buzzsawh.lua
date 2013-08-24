Buzzsaw = require "buzzsaw"
local BuzzsawH = class("BuzzsawH", Buzzsaw)

function BuzzsawH:initialize(x, y)
	Buzzsaw.initialize(self,x,y)
end

function BuzzsawH:update(dt)
	if self.l == self.tx*tsize and self.t == self.ty*tsize then
		local tile = mainlyr(self.tx+self.dir, self.ty)
		if tile.properties.rail then
			self.tx = self.tx + self.dir
			tween(self.spd, self, {l = self.tx*tsize})
		else
			self.dir = self.dir*-1
			love.audio.play(self.snd)
		end
	end
	Buzzsaw.update(self,dt)
end

function BuzzsawH:draw()
	Buzzsaw.draw(self)
end

return BuzzsawH