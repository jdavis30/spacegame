--######################################################################--
--########################## Player Module #############################--
--######################################################################--
--Author: Jasper Davis
--Date created: 12/29/2015
--Last Edited: 12/29/2015 
--By: Jasper Davis
--Basic Function: makes the player's ship and systems.
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
function newPlayer(xi,yi,anglei,acci,rotacci,xvi,yvi,anglevi,colori)
--//////////////////////////////////////////////////////////--
--///////////////////// PHASE A: INSTANCE //////////////////--
--//////////////////////////////////////////////////////////--
--	Creates the first instance of the player object. This instance
--	which is created can be viewed in the same fashion as a class for an object.
	player = {
		--player x and y coordinates
		x = xi,
		y = yi,
		--player angle
		angle = anglei,
		--player collision radius
		radius = 30,
		--player acceleration
		acc = acci,
		--player rotational acceleration
		rotacc = rotacci,
		--player maximum velocity
		maxv = 300,
		--player minimum velocity
		minv = -300,
		--player maximum rotational velocity
		maxrotv = 20,
		--player minimum rotational velocity
		minrotv = -20,
		--player velocity vector x and y axes
		xv = xvi,
		yv = yvi,
		--player rotational velocity
		anglev = anglevi,
		--player gun recoil:currently not in play yet.
		gunrec = 2,
		--player color
		color = colori,
		--thrusting variables, help with drawing the thrust flares
		leftThrust = false,
		rightThrust = false,
		forThrust = false,
		aftThrust = false,
		--cannon counters. prevents infinite shots.
		leftCannonCount = 8,
		rightCannonCount = 2,
	}

--////////////////////////////////////////////////////////--
--/////////////////// PHASE B: FUNCTIONS /////////////////--
--////////////////////////////////////////////////////////--
--======================-- SECTION B1: UPDATING --==================--
--	First function updates all the dynamic parts of the code. I will break it down
--	With Comments
	function player:update(dt)
		-- the thrust booleans are reset to false, until they are checked once again.
		leftThrust = false
		rightThrust = false
		forThrust = false
		aftThrust = false
		-- the velocity is added to the current position of the player(with consideration to
		--	delta of time.)
		self.x = self.x + (self.xv*dt)
		self.y = self.y + (self.yv*dt)
		self.angle = self.angle + (self.anglev*dt)
		--if the velocities are over a their maximum, they are set back to
		--the cap level.
		if self.xv > self.maxv then
			self.xv = self.maxv
		elseif self.xv < self.minv then
			self.xv = self.minv
		end
		if self.yv > self.maxv then
			self.yv = self.maxv
		elseif self.yv < self.minv then
			self.yv = self.minv
		end
		if self.anglev > self.maxrotv then
			self.anglev = self.maxrotv
		elseif self.anglev < self.minrotv then
			self.anglev = self.minrotv
		end
		--if the thruster buttons are pressed here, accelerate the ship.
		if love.keyboard.isDown("up", "w") then
			self.xv = self.xv + (self.acc*math.cos(self.angle)*dt)
			self.yv = self.yv + (self.acc*math.sin(self.angle)*dt)
			forThrust = true
		end
		if love.keyboard.isDown("down", "s") then
			self.xv = self.xv - (self.acc*math.cos(self.angle)*dt)
			self.yv = self.yv - (self.acc*math.sin(self.angle)*dt)
			aftThrust = true
		end
		if love.keyboard.isDown("left", "a") then
			self.anglev = self.anglev - (self.rotacc*dt)
			self.anglev = self.anglev - (self.rotacc*dt)
			self.xv = self.xv - (2*self.acc/2*math.sin(self.angle)*dt)
			self.yv = self.yv - (2*self.acc/2*math.cos(self.angle)*dt)
			rightThrust = true
		end
		if love.keyboard.isDown("right", "d") then
			self.anglev = self.anglev + (self.rotacc*dt)
			self.anglev = self.anglev + (self.rotacc*dt)
			self.xv = self.xv + (2*self.acc/2*math.sin(self.angle)*dt)
			self.yv = self.yv + (2*self.acc/2*math.cos(self.angle)*dt)
			leftThrust = true
		end
		--resets position if "r" is pressed. It's a debug button.
		if love.keyboard.isDown("r") then
			self.x = 0
			self.y = 0
			self.xv = 0
			self.yv = 0
			self.anglev = 0
		end
	end

--======================-- SECTION B2: DRAWING --=======================--
--	The draw function draws the ship. It is fairly nonsensical
--	(since it was just done till it looked right), but the comments will break it down.
	function player:draw(x,y,angle,size)
		--reset starting position to origin if it isn't already
		love.graphics.origin()
		--place your new drawing axes location where the ship is.
		love.graphics.translate(x, y)
		--rotate drawing axes to match angle
		love.graphics.rotate(angle)
		-->>>>>>>>>>>>>>>>>>>>>>>>DRAWING THRUSTER FLAMES
		if (love.keyboard.isDown("up", "w") and paused == false) or (paused == true and forThrust == true) then
			love.graphics.setColor(18,196,255, 90)
			love.graphics.polygon("fill", -45 * size,-15 * size,-45 * size, 15 * size, -50 * size, 0 * size)
		end
		if (love.keyboard.isDown("down", "s") and paused == false) or (paused == true and aftThrust == true) then
			love.graphics.setColor(18,196,255,90)
			love.graphics.polygon("fill", 40 * size,-10 * size,40 * size, 10 * size, 45 * size, 0 * size)
		end
		if (love.keyboard.isDown("left", "a") and paused == false) or (paused == true and rightThrust == true) then
			love.graphics.setColor(18,196,255,90)
			love.graphics.rotate((math.pi)/3)
			love.graphics.translate(15 * size,0 * size)
			love.graphics.rotate((math.pi/3))
			love.graphics.polygon("fill",27 * size, -7 * size, 27 * size, 7 * size, 37 * size, 0 * size)
			love.graphics.rotate(-(math.pi/3))
			love.graphics.translate(-15 * size, 0 * size)
			love.graphics.rotate(-((math.pi)/3))
		end
		if (love.keyboard.isDown("right", "d") and paused == false) or (paused == true and leftThrust == true) then
			love.graphics.setColor(18,196,255,90)
			love.graphics.rotate(-(math.pi)/3)
			love.graphics.translate(15 * size,0 * size)
			love.graphics.rotate(-(math.pi/3))
			love.graphics.polygon("fill",27 * size, -7 * size, 27 * size, 7 * size, 37 * size, 0 * size)
			love.graphics.rotate((math.pi/3))
			love.graphics.translate(-15 * size, 0 * size)
			love.graphics.rotate(((math.pi)/3))
		end
		-->>>>>>>>>>>>>>>>>>>>>>>>>>DRAWING BLASTERS
		love.graphics.setColor(189,176,134)
		love.graphics.rectangle("fill", 5 * size, 15 * size, 30 * size, 5 * size)
		love.graphics.rectangle("fill", 5 * size, -20 * size, 30 * size, 5 * size)
		-->>>>>>>>>>>>>>>>>>>>>>>>>>DRAWING THRUSTERS
		love.graphics.setColor(142,143,145)
		love.graphics.rectangle("fill",-45 * size, -15 * size, 30 * size, 30 * size)
		love.graphics.rectangle("fill",10 * size, -10 * size, 30 * size, 20 * size)
		love.graphics.rotate((math.pi)/3)
		love.graphics.translate(15 * size,0 * size)
		love.graphics.rotate((math.pi/3))
		love.graphics.rectangle("fill",7 * size, -7 * size, 20 * size, 14 * size)
		love.graphics.rotate(-(math.pi/3))
		love.graphics.translate(-15 * size, 0 * size)
		love.graphics.rotate(-((math.pi)/3))
		love.graphics.rotate(-(math.pi)/3)
		love.graphics.translate(15 * size,0 * size)
		love.graphics.rotate(-(math.pi/3))
		love.graphics.rectangle("fill",7 * size, -7 * size, 20 * size, 14 * size)
		love.graphics.rotate((math.pi/3))
		love.graphics.translate(-15 * size, 0 * size)
		love.graphics.rotate(((math.pi)/3))
		-->>>>>>>>>>>>>>>>>>>>>>>>>>>DRAWING BODY
		love.graphics.setColor(self.color)
		love.graphics.circle("fill",0,0,self.radius * size,40 * size)
		-->>>>>>>>>>>>>>>>>>>>>>>>>>>DRAWING VISOR
		love.graphics.setColor(132,164,122,255)
		love.graphics.arc("fill", 0,0,(self.radius-10) * size,(3*math.pi)/2, (5*math.pi)/2, 30 * size)
		love.graphics.origin()
		love.graphics.setColor(255,255,255,255)
	end
	-->>>>Because of how short this part is, I decided it didn't need a full phase.
	--copies player to whatever variable you are tying it to.
	return player
end