hpconfig = {}
hpconfig.allowed = {TEAM_GUN, TEAM_MAYOR} -- What teams can open the menu?
hpconfig.gryffindor = {TEAM_CITIZEN} -- gryffindor team
hpconfig.hufflepuff	= {TEAM_CITIZEN} -- hufflepuff team
hpconfig.ravenclaw = {TEAM_MEDIC} -- ravenclaw team
hpconfig.slytherin = {TEAM_MAYOR} -- slytherin team

util.AddNetworkString( "openPointsMenu" )
util.AddNetworkString( "pointsMath" )

local function pointsMenu(ply, args) -- tells the caller of the chat command to open the points menu, will only open if their team is in the config
	if table.HasValue(hpconfig.allowed, ply:Team()) then
	net.Start("openPointsMenu")
	net.Send(ply)
	return ""
	end
end

local function savePoints() -- saves the points when the server stops or shutsdown
	file.Write( "ge_points.txt", GetGlobalInt("ge_points") )
	file.Write( "se_points.txt", GetGlobalInt("se_points") )
	file.Write( "re_points.txt", GetGlobalInt("re_points") )
	file.Write( "he_points.txt", GetGlobalInt("he_points") )
	print("house points saved!")
end

local function setPointsInit() -- gets the saved point values and sets them when the server starts
	local ge_val = tonumber(file.Read( "ge_points.txt" ), 10)
	local se_val = tonumber(file.Read( "se_points.txt" ), 10)
	local re_val = tonumber(file.Read( "re_points.txt" ), 10)
	local he_val = tonumber(file.Read( "he_points.txt" ), 10)
	SetGlobalInt("ge_points", ge_val)
	SetGlobalInt("se_points", se_val)
	SetGlobalInt("re_points", re_val)
	SetGlobalInt("he_points", he_val)
	print("house points set!")
end

local function pointsMath( len, ply ) -- function that does all the math for the points
	local pointsa = net.ReadInt(16)
	local house = net.ReadString()
	if table.HasValue(hpconfig.allowed, ply:Team()) or ply:IsAdmin() then
	if GetGlobalInt(house) + pointsa < 0 then
		SetGlobalInt(house, 0)
	else
	SetGlobalInt(house, GetGlobalInt(house) + pointsa)
	end
	end
	if pointsa < 0 then
		for k,v in pairs(player.GetAll()) do
			if v != ply then
				if house == "ge_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " took " .. pointsa*-1 .. " points from " .. "Gryffindor")
				elseif house == "se_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " took " .. pointsa*-1 .. " points from " .. "Slytherin")
				elseif house == "re_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " took " .. pointsa*-1 .. " points from " .. "Ravenclaw")
				elseif house == "he_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " took " .. pointsa*-1 .. " points from " .. "Hufflepuff")
				end
			end
		end
	elseif pointsa >= 0 then
		for k,v in pairs(player.GetAll()) do
			if v != ply then
				if house == "ge_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " gave " .. pointsa .. " points to " .. "Gryffindor")
				elseif house == "se_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " gave " .. pointsa .. " points to " .. "Slytherin")
				elseif house == "re_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " gave " .. pointsa .. " points to " .. "Ravenclaw")
				elseif house == "he_points" then
					DarkRP.notify(v, 1, 4, ply:Name() .. " gave " .. pointsa .. " points to " .. "Hufflepuff")
				end
			end	
		end
	end
end

concommand.Add("check2", function() -- debug command for checking values
	print(GetGlobalInt("ge_points"))
	print(GetGlobalInt("se_points"))
	print(GetGlobalInt("he_points"))
	print(GetGlobalInt("re_points"))
end)

concommand.Add("resethppoints", function( ply, cmd, args ) -- 4 different args g, r, h, s
	if ply:IsAdmin() then
		if args[1] == "g" then
	SetGlobalInt("ge_points",0)
		elseif args[1] == "r" then
	SetGlobalInt("re_points",0)
		elseif args[1] == "h" then
	SetGlobalInt("he_points",0)
		elseif args[1] == "s" then
	SetGlobalInt("se_points",0)
		end
	end
end)

net.Receive( "pointsMath", pointsMath )
hook.Add("Initialize", "setPointsInit", setPointsInit)
hook.Add("ShutDown", "save_points", savePoints)
DarkRP.defineChatCommand("pointsmenu", pointsMenu)