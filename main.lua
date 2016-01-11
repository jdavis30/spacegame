function love.load()
	require("code/intro")
	require("code/game")
	state = "intro"
end
function love.update(dt)
	if state == "intro" then
		updateIntro(dt)
	elseif state == "game" then
		updateGame(dt)
	end
end
function love.draw()
	if state == "intro" then
		drawIntro()
	elseif state == "game" then
		drawGame()
	end
end
