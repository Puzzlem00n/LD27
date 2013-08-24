Buzzsaw = require "buzzsaw"
local BuzzsawV = class("BuzzsawV", Buzzsaw)

function BuzzsawV:initialize(x, y)
	Buzzsaw.initialize(self,x,y)
end

function BuzzsawV:update(dt)
	if self.l == self.tx*tsize and self.t == self.ty*tsize then
		local tile = mainlyr(self.tx, self.ty+self.dir)
		if tile.properties.rail then
			self.ty = self.ty + self.dir
			tween(self.spd, self, {t = self.ty*tsize})
		else
			self.dir = self.dir*-1
			love.audio.play(self.snd)
		end
	end
	Buzzsaw.update(self,dt)
end

function BuzzsawV:draw()
	Buzzsaw.draw(self)
end

return BuzzsawV