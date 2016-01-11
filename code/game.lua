--####################################################################--
--########################## Game Module #############################--
--####################################################################--
--Author: Jasper Davis
--Date created: 12/29/2015
--Last Edited: 12/29/2015 
--By: Jasper Davis
--Basic Function: groups together other base modules together to simplify
--main.lua and organise game system.
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
--=================-- SECTION A1: REQUIREMENTS --=======================--
--	this part calls all the modules which game.lua uses to function.
--	Currently Used Modules:
--		>spacegame/code/collision.lua
--		>spacegame/code/player.lua
--		>spacegame/code/background.lua
--		>spacegame/code/camera.lua
--		>spacegame/code/laser.lua
--		>spacegame/code/console.lua
require("code/collision")
require("code/player")
require("code/background")
require("code/camera")
require("code/laser")
require("code/console")

--===================-- SECTION A2: INSTANTIATION --======================--
--	This part creates instants for all objects to be used in the following functions.
--
--instance of player object: see spacegame/code/player.lua for more information.
player1 = newPlayer(0,0,-90,75,3,0,0,0,{131,192,255,255})
--instance of camera object: see spacegame/code/camera.lua for more information.
camera1 = newCamera(200,200,1,1)
--instance of background object: see spacegame/code/background.lua for more information.
background1 = newBackground(800)
--instance of console object: see spacegame/code/console.lua for more information.
console1 = newConsole()

--===================-- SECTION A3: FINAL SETUP --========================--
--	any extra pieces which are needed before any functions can be initialized
--	are placed here.
--
--Added array to hold laser objects within, for an easier time coding the update and draw functions.
lasers = {}
--Set the camera object to follow the player object.
camera1:follow(player1)
--added a variable which dictates whether the game is paused or not. It starts out in the false position, denoting the game does not start paused.
paused = false
--added a variable which dictates whether the console is shown or not. false denotes that the console is not shown.
showConsole = false

--//////////////////////////////////////////////////////////////////////--
--/////////////////////////--PHASE B: UPDATES--/////////////////////////--
--//////////////////////////////////////////////////////////////////////--
--	The function below updates almost everything in the game which occurs, frame by frame.
--	This includes game states, object positions and states, new instantiations, variable
--	reassignments, new deletions, as well as input reads and collision detections.
--
--
--This is the beginning of the creation of the function.
function updateGame(dt)

--========================-- SECTION B1: KEYPRESSES --==================--
--	All keypresses and actions carried out due to key presses are handled here.
--
	--when the button "1" is pressed on the keyboard, the camera size is changed to hold the background,
	--the camera object is set to follow the background object, and the console is written to.
	--For more info on the console write function, go to spacegame/code/console.lua section B1.
	if love.keyboard.isDown("1") then
		camera1:follow(background1)
		camera1.size = background.width/love.graphics.getWidth()
		console1:write("focusing on background")
	--when the button "1" is pressed on the keyboard, the camera size is changed to 1 again,
	--the camera object is set to follow the player object, and the console is written to.
	elseif love.keyboard.isDown("2") then
		camera1:follow(player1)
		camera1.size = 1
		console1:write("focusing on player")
	--when the button "=" is pressed on the keyboard, the camera size is changed by .1,
	--and the console is written to.
	elseif love.keyboard.isDown("=") then
		camera1.size = camera1.size + .1
		console1:write("zooming out")
	--when the button "=" is pressed on the keyboard, the camera size is changed by -.1,
	--and the console is written to.
	elseif love.keyboard.isDown("-") then
		camera1.size = camera1.size - .1
		console1:write("zooming in")
	end
	--when the button "q" is pressed on the keyboard and the counter for the left cannon is at 0,
	--a new instance of a laser object is made, the right cannon counter is incremented, modulo 30, and
	--the console is written to. if only "q" is being pressed and the counter is not at 0, the counter is
	--incremented, modulo 30.
	if love.keyboard.isDown("q") and player1.leftCannonCount == 0 then
		table.insert(lasers, newLaser(player1.x,player1.y,10,300,player1.angle,{131,192,255,255}))
		player1.leftCannonCount = math.fmod((player1.leftCannonCount + 1), 30)
		console1:write("left cannon fired.")
	elseif love.keyboard.isDown("q") and player1.leftCannonCount ~= 0 then
		player1.leftCannonCount = math.fmod((player1.leftCannonCount + 1), 30)
	end
	--when the button "e" is pressed on the keyboard and the counter for the right cannon is at 0,
	--a new instance of a laser object is made, the right cannon counter is incremented, modulo 30, and
	--the console is written to. if only "q" is being pressed and the counter is not at 0, the counter is
	--incremented, modulo 30.
	if love.keyboard.isDown("e") and player1.rightCannonCount == 0 then
		table.insert(lasers, newLaser(player1.x,player1.y,10,300,player1.angle,{131,192,255,255}))
		player1.rightCannonCount = math.fmod((player1.rightCannonCount + 1), 30)
		console1:write("right cannon fired.")
	elseif love.keyboard.isDown("e") and player1.rightCannonCount ~= 0 then
		player1.rightCannonCount = math.fmod((player1.rightCannonCount + 1), 30)
	end

--=======================-- SECTION B2: BOUNDS --========================--
--	If the player goes out of the bounds of the map, he is placed back in bounds on the other side of the map.
--	This is in an attempt to make the map feel non-euclidian and, through that method, larger.
	--right-most bound
	if player1.x > 1500 then
		if camera.following == player1 then
			camera1.x = -1500 - (player1.x - camera1.x)
		end
		player1.x = -1500
		--console write
		console1:write("exiting right-most bounds, setting new location.")
	end
	--left-most bound
	if player1.x < -1500 then
		if camera.following == player1 then
			camera1.x = 1500 - (player1.x - camera1.x)
		end
		player1.x = 1500
		--console write
		console1:write("exiting left-most bounds, setting new location.")
	end
	--lower-most bound
	if player1.y > 1500 then
		if camera.following == player1 then
			camera1.y = -1500 - (player1.y - camera1.y)
		end
		player1.y = -1500
		console1:write("exiting upper bounds, setting new location.")
	end
	--upper-most bound
	if player1.y < -1500 then
		if camera.following == player1 then
			camera1.y = 1500 - (player1.y - camera1.y)
		end
		player1.y = 1500
		console1:write("exiting lower bounds, setting new location.")
	end

--================-- SECTION B3: OBJECT UPDATES --==================--
--	After all global variables have been checked and updated, and all 
--	special cases have been taken into account, the objects and their
--	variables are updated.

	--if the game is in a paused state, the player's variables do not update.
	--nor do the lasers'.
	if paused == false then
		--player1 is updated
		player1:update(dt)
		--all lasers in the laser array are updated.
		for i=1, table.getn(lasers) do
			lasers[i]:update(dt)
		end
	end
	--the camera is updated.
	camera1:update(dt)
end

--/////////////////////////////////////////////////////////--
--////////////////////// PHASE C: DRAWING//////////////////--
--/////////////////////////////////////////////////////////--
--	This phase draws the game frame by frame.
--	Because the majority of this phase takes place within 
--	each object, it would be more self-explanatory to look
--	through the various modules which you will see.

--start of drawGame function
function drawGame()
	--camera draws background. For more info on camera draw function,
	--go to spacegame/code/camera.lua, section B3. For background draw
	--function, look at spacegame/code/background.lua, section B1.
	camera1:draw(background1)
	for i=1, table.getn(lasers) do
		--camera draws lasers. for laser draw function, look at 
		--spacegame/code/laser.lua, section B2.
		camera1:draw(lasers[i])
	end
	--camera draws player. for player draw function, look at 
	--spacegame/code/player.lua, section B2.
	camera1:draw(player1)
	--showConsole is true, then the console will be drawn
	--for console draw function, look at 
	--spacegame/code/console.lua, section B2.
	if showConsole then
		console1:draw()
	end
end


--////////////////////////////////////////////////////////////--
--////////////////////// PHASE D: KEYPRESSES//////////////////--
--////////////////////////////////////////////////////////////--
--	Sometimes, you only want something to occur once when a key is
--	pressed, rather than constantly. this function carries this out.
function love.keypressed(key)
	--If "escape" is pressed, the game will toggle between paused and unpaused.
	--The reason for having it in the key-pressed section is so that the game
	--does not toggle between paused and unpaused in rapid succession.
	if key == "escape" and paused == false then
		paused = true
	elseif key == "escape" and paused == true then
		paused = false
	end
	-- if "`" is pressed, the console togles between being shown or not.
	-- a message is also written to the console.
	if key == "`" and showConsole == false then
		console1:write("Console is On")
		showConsole = true
	elseif key == "`" and showConsole == true then
		console1:write("Console is Off")
		showConsole = false
	end
end