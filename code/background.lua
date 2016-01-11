--##########################################################################--
--########################## Background Module #############################--
--##########################################################################--
--Author: Jasper Davis
--Date created: 12/29/2015
--Last Edited: 12/29/2015 
--By: Jasper Davis
--Basic Function: shows the stars and effects in the background.
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
function newBackground()
--//////////////////////////////////////////////////////////--
--///////////////////// PHASE A: INSTANCE //////////////////--
--//////////////////////////////////////////////////////////--
--	Creates the first instance of the console object. This instance
--	which is created can be viewed in the
--	same fashion as a class for an object.
	background = {
		x = 0,
		y = 0,
		numstars = 400,
		angle = 0,
		stars = {},
		width = 3000,
		height = 3000
	}
	--Gives coordinates to all the stars.
	for i = 1,background.numstars do
		background.stars[i] = {}
		local starx = math.random(-background.width/2, background.width/2)
		local stary = math.random(-background.height/2, background.height/2)
		background.stars[i][1] = starx
		background.stars[i][2] = stary
	end
--////////////////////////////////////////////////////////--
--/////////////////// PHASE B: FUNCTIONS /////////////////--
--////////////////////////////////////////////////////////--

--======================-- SECTION B1: DRAWING --=======================--
--Draws all the stars  9 times, producing 9 repeats of the background all together.
	function background:draw(x,y, angle, size)
		love.graphics.translate(x,y, angle)
		love.graphics.setBackgroundColor(50,35,45)
		love.graphics.setColor(255,255,255)
		for i = 1, 200 do
			love.graphics.points(self.stars[i][1] * size, self.stars[i][2] * size)
		end
		for i = 1, 200 do
			love.graphics.points((self.stars[i][1] + self.width) * size, self.stars[i][2] * size)
		end
		for i = 1, 200 do
			love.graphics.points((self.stars[i][1] - self.width) * size, self.stars[i][2] * size)
		end
		for i = 1, 200 do
			love.graphics.points(self.stars[i][1] * size, (self.stars[i][2] + self.height) * size)
		end
		for i = 1, 200 do
			love.graphics.points(self.stars[i][1] * size, (self.stars[i][2] - self.height) * size)
		end
		for i = 1, 200 do
			love.graphics.points((self.stars[i][1] + self.width) * size, (self.stars[i][2] + self.height) * size)
		end
		for i = 1, 200 do
			love.graphics.points((self.stars[i][1] - self.width) * size, (self.stars[i][2] - self.height) * size)
		end
		for i = 1, 200 do
			love.graphics.points((self.stars[i][1] - self.width) * size, (self.stars[i][2] + self.height) * size)
		end
		for i = 1, 200 do
			love.graphics.points((self.stars[i][1] + self.width) * size, (self.stars[i][2] - self.height) * size)
		end
		love.graphics.origin()
		love.graphics.setColor(255,255,255,255)
	end

	-->>>>Because of how short this part is, I decided it didn't need a full phase.
	--copies background to whatever variable you are tying it to.
	return background
end