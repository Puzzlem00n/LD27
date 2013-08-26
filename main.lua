require "requirer"
require "menu"
require "game"
require "win"
require "instruct"

function love.load()
	changestate(menu)
	paused = false
	pausedopac = 0
	maxframe = 0.1
	love.graphics.setNewFont("res/emulogic.ttf", 15)
	music = love.audio.newSource("res/XPtTotD.ogg", "stream")
	music:setLooping(true)
	love.audio.play(music)
end

function love.update(dt)
	if not paused then
		local gdt = dt
		while gdt > 0 do
			local nowdt = math.min(maxframe, gdt)
			gamestate.update(nowdt)
			gdt = gdt - maxframe
		end
	end
	--arc.check_keys(dt)
end

function love.draw()
	gamestate.draw()
	love.graphics.setColor(0,0,0,pausedopac)
	love.graphics.rectangle("fill", 0, 0, love.graphics:getWidth(), love.graphics:getHeight())
	love.graphics.setColor(255,255,255,255)
	--arc.clear_key()
	gui.core.draw()
end

function changestate(state, num)
	gamestate = state
	if num then gamestate.load(num)
	else gamestate.load() end
end

function love.mousepressed(x, y, button)
	if gamestate.mousepressed then
		gamestate.mousepressed(x, y, button)
	end
end

function love.mousereleased(x, y, button)
	if gamestate.mousereleased then
		gamestate.mousereleased(x, y, button)
	end
end

function love.keypressed(key, code)
	if gamestate.keypressed then
		gamestate.keypressed(key)
	end
	--arc.set_key(key)
	gui.keyboard.pressed(key, code)
end

function love.keyreleased(key)
	if gamestate.keyreleased then
		gamestate.keyreleased(key)
	end
end

function love.focus(f)
  if not f then
    pausedopac = 170
	love.audio.pause()
	paused = true
  else
    pausedopac = 0
	love.audio.resume()
	paused = false
  end
end

function sign(x)
	return x < 0 and -1 or (x > 0 and 1 or 0)
end