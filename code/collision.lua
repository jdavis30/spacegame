function collision(ent1, ent2)
	if math.sqrt(((ent1.x-ent2.x)*(ent1.x-ent2.x)) + ((ent1.y-ent2.y)*(ent1.y-ent2.y))) <= (ent1.radius+ent2.radius) then
		return true
	end
end