--######################################################################--
--########################## Intro Module #############################--
--######################################################################--
--Author: Jasper Davis
--Date created: 12/29/2015
--Last Edited: 12/29/2015
--By: Jasper Davis
--Basic Function: Shows the intro of the game. first, the logo is covered
--				  by a black circle the same size as it. the circle then
--				  then cycles to white and begins to disappear, leaving
--                the logo behind. the text then gains opacity below.
--				  After this, the screen turns to black.
--
--for more info, contact who last edited:jasperdavis95@gmail.com
--
--Code standard form:
--	>Comments hold notes for line or lines immediately below it.
--	>Code is split into phases, then sections of phases, for ease
--	 of navigation, with Letters denoting phases, and numerals
--	 denoting sections of phases.
--	>Phases are denoted via --/-- borders and  sections, via --=--
--	 borders.
--
--////////////////////////////////////////////////////////////////--
--//////////////////-- PHASE A: Initialization --/////////////////--
--////////////////////////////////////////////////////////////////--
--	Anything which must be present before the game begins must be accounted
--	for beforehand. this phase makes sure that all modules which will be needed,
--	all variables and arrays which will be needed, and all objects which will be
--	needed are on hand for the program before anything must be manipulated.
--
--
--Produces a new table called intro. this will have most of the important items.
intro = {logo = love.graphics.newImage("images/loveLogo.png"),
	r = 0,
	scalex = .75,
	scaley = .75,
}
-- creates new font for the animation to use and sets it.
loveFont = love.graphics.newFont("fonts/ThrowMyHandsUpintheAirBold.ttf", 30)
love.graphics.setFont(loveFont)
--Setting all the miscellanious variables.
-- The actual logo size
intro.logox = intro.logo:getWidth()
intro.logoy = intro.logo:getHeight()
-- defines the intro colors
--circle covering logo color
intro.cColor = {0,0,0,255}
--text color
intro.tColor = {131,192,240,0}
intro.lColor = {255,255,255,255}
time = 0

--//////////////////////////////////////////////////////////////////////--
--/////////////////////////--PHASE B: UPDATES--/////////////////////////--
--//////////////////////////////////////////////////////////////////////--
--	The function below updates almost everything in the intro which occurs, frame by frame.
--
--
--
--This is the beginning of the creation of the function.
function updateIntro(dt)
	--scales intro size
	intro.sizex = intro.logox * intro.scalex
	intro.sizey = intro.logoy * intro.scaley
	--defines where the logo will be centered.
	intro.x = (love.graphics.getWidth()/2) - (intro.sizex/2)
	intro.y = (love.graphics.getHeight()/2) - (intro.sizey/2)
	--since the circle is drawn from the center, it simply needs
	--do be drawn in the center of the screen.
	intro.cx = love.graphics.getWidth()/2
	intro.cy = love.graphics.getHeight()/2
	--this next part happens in seconds
	--when time is between .07 seconds and .2 seconds, brighten the circle.
	if time > .07 and time <= .2 then
		intro.cColor[1] = intro.cColor[1] + (255/.130)*dt
		intro.cColor[2] = intro.cColor[2] + (255/.130)*dt
		intro.cColor[3] = intro.cColor[3] + (255/.130)*dt
	--when time is between .25 seconds and .45 seconds, lower the circle's
	--opacity.
	elseif time > .25 and time < .45 then
		intro.cColor[4] = intro.cColor[4] - (255/.2)*dt 
	--when time is between .55 seconds and .75 seconds, make sure the circle
	--opacity is 0 and begin brightening the text.
	elseif time > .55 and time < .75 then
		intro.cColor[4] = 0
		intro.tColor[4] = intro.tColor[4] + (255/.2)*dt
	--when time is between 1.15 seconds and 1.8 seconds, dim the logo and text.
	elseif time > 1.15 and time < 1.8 then
		intro.lColor[4] = intro.lColor[4] - (255/.65)*dt
		intro.tColor[4] = intro.tColor[4] - (255/.65)*dt
	--when time is between 1.8 and 1.85 seconds, make sure both logo and
	--text are invisible
    elseif time > 1.8 and time < 1.85 then
    	intro.lColor[4] = 0
    	intro.tColor[4] = 0
	elseif time > 2 then
	--when time is greater than 2 seconds, switch the state to game.
		state = "game"
	end
	time = time + dt
end

--/////////////////////////////////////////////////////////--
--////////////////////// PHASE C: DRAWING//////////////////--
--/////////////////////////////////////////////////////////--
--	This phase draws the intro frame by frame.

--start of drawGame function
function drawIntro()
	--draw the logo
	love.graphics.setColor(intro.lColor)
	love.graphics.draw(intro.logo, intro.x, intro.y, 0, intro.scalex, intro.scaley, 0,0)
	--draw the circle over the logo
	love.graphics.setColor(intro.cColor)
	love.graphics.circle("fill", intro.cx, intro.cy, (intro.sizex/2) - 10, 100)
	--draw the intro text.
	love.graphics.setColor(intro.tColor)
	love.graphics.printf( "Made with Löve", (love.graphics.getWidth()/2) - (intro.sizex + 5), (love.graphics.getHeight()/2) + (intro.sizey/2), 400, "center", 0, 1, 1, 0, 0, 0, 0 )
	--reset the settings.
	love.graphics.origin()
	love.graphics.setColor(255,255,255,255)
end
