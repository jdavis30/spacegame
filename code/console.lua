--######################################################################--
--########################## Console Module #############################--
--######################################################################--
--Author: Jasper Davis
--Date created: 12/29/2015
--Last Edited: 12/29/2015 
--By: Jasper Davis
--Basic Function: shows debug info, thus (hopefully) assisting in fixing
--errors.
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
function newConsole()
--//////////////////////////////////////////////////////////--
--///////////////////// PHASE A: INSTANCE //////////////////--
--//////////////////////////////////////////////////////////--
--	Creates the first instance of the console object. This instance
--	which is created can be viewed in the
--	same fashion as a class for an object.
	console = {
		--list which holds debug messages.
		list = {}
	}

--////////////////////////////////////////////////////////--
--/////////////////// PHASE B: FUNCTIONS /////////////////--
--////////////////////////////////////////////////////////--
--	Functions for having the console do its thing.

--========================-- SECTION B1: WRITE --==================--
--	The write function takes a string and adds it to the debug message list.
--	For now though, I've only allowed it to hold 10 messages
	function console:write(message)
		table.insert(self.list, 1, message)
		if #self.list > 10 then
			for i = 1, #self.list - 10 do
				table.remove(self.list, #self.list)
			end
		end
	end

--========================-- SECTION B2: DRAW --==================--
--	Draws a black background and writes all messages on the background.
	function console:draw()
		love.graphics.setColor(0,0,0,200)
		love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),130)
		love.graphics.setColor(255,255,255,200)
		for i = 1, #self.list do
			love.graphics.print(self.list[i], 10, i * 10 + 5, 0, .4, .4, 0, 0)
		end
	end
	-->>>>Because of how short this part is, I decided it didn't need a full phase.
	--copies console to whatever variable you are tying it to.
	return console
end