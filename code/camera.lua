--######################################################################--
--########################## Camera Module #############################--
--######################################################################--
--Author: Jasper Davis
--Date created: 12/29/2015
--Last Edited: 12/29/2015 
--By: Jasper Davis
--Basic Function: Keeps the screen focused on one object.
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
function newCamera(xi,yi,sizei)
--//////////////////////////////////////////////////////////--
--///////////////////// PHASE A: INSTANCE //////////////////--
--//////////////////////////////////////////////////////////--
--	Creates the first instance of the camera object. This instance
--	which is created and can be viewed in the
--	same fashion as a class for an object.
	camera = {
		-- x and  position
		x = xi,
		y = yi,
		--size of the screen on the camera. causes a zoom effect
		size = sizei,
		-- delay of camera. causes a pan effect.
		delay = 20,
		-- holds a basic set of x and y coordinates.
		following = {
			x = 0,
			y = 0,
		}
	}
--////////////////////////////////////////////////////////--
--/////////////////// PHASE B: FUNCTIONS /////////////////--
--////////////////////////////////////////////////////////--
--======================-- SECTION B1:FOLLOWING --===================--
--	This function allows for the camera to keep track of an object on the screen.
--	it simply sets it up so that the camera has the object as a variable.
--  this way it can at any point grab the coordinates of the object.
	function camera:follow(object)
		self.following = object
	end
--======================-- SECTION B2: UPDATING --==================--
--	This gets the camera over the object it is following. the equations are
--	slightly different though, because it takes into account a delay, so the
--	camera pans onto the object.
	function camera:update(dt)
		self.x = self.x - (self.x - self.following.x)/(self.delay)
		self.y = self.y - (self.y - self.following.y)/(self.delay)
	end
--======================-- SECTION B3: DRAWING --=======================--
--	The concept in this part is alittle less straightforward than the others.
--	Basically, all these objects are on a coordinate plane with  the coordinates
--	(0,0) located in its upper left-hand corner. the camera draw function basically
--	centers what the camera is over by "pushing" all the objects it draws on the 
--	plane in relation to the camera instead of the plane itself.
	function camera:draw(entity)
		entity:draw((entity.x - camera.x) / self.size + love.graphics.getWidth()/2, (entity.y - camera.y) / self.size + love.graphics.getHeight()/2, entity.angle, 1/self.size)
	end
	-->>>>Because of how short this part is, I decided it didn't need a full phase.
	--copies camera to whatever variable you are tying it to.
	return camera
end