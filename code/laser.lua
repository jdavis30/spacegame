--######################################################################--
--########################## Laser Module ##############################--
--######################################################################--
--Author: Jasper Davis
--Date created: 12/29/2015
--Last Edited: 12/29/2015 
--By: Jasper Davis
--Basic Function: projectile that flies in one direction,hitting anything
--				  It comes into contact with(eventual goal.)
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
function newLaser(xi,yi,sizei,vi,anglei,colori)
--//////////////////////////////////////////////////////////--
--///////////////////// PHASE A: INSTANCE //////////////////--
--//////////////////////////////////////////////////////////--
--	Creates the first instance of the console object. This instance
--	which is created can be viewed in the
--	same fashion as a class for an object.
	laser = {
		x = xi,
		v = vi,
		y = yi,
		angle = anglei,
		size = sizei,
		color = colori,
	}

--////////////////////////////////////////////////////////--
--/////////////////// PHASE B: FUNCTIONS /////////////////--
--////////////////////////////////////////////////////////--

--======================-- SECTION B1: UPDATING --==================--
--	Basic kinematic functions for now.
	function laser:update(dt)
		self.x = self.x + (self.v * math.cos(self.angle))*dt
		self.y = self.y + (self.v * math.sin(self.angle))*dt
	end
--======================-- SECTION B2: DRAWING --=======================--
--Draws an ellipse representative of the laser.
	function laser:draw(x,y,angle,size)
		love.graphics.translate(x,y)
		love.graphics.rotate(angle)
		love.graphics.setColor(self.color)
		love.graphics.ellipse("fill", 0, 0, self.size * size, (self.size/10) * size)
		love.graphics.origin()
		love.graphics.setColor(255,255,255,255)
	end
	return laser
end