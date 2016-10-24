AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Points Stick"
    SWEP.Slot = 1
    SWEP.SlotPos = 3
end

DEFINE_BASECLASS("stick_base")

SWEP.Instructions = "Right Click to change mode, reload to change ammount, left click to give/take"

SWEP.Spawnable = true
SWEP.Category = "Harry Potter"
SWEP.Primary.Distance = 75
SWEP.StickColor = Color(127, 0, 255)

SWEP.Switched = true
local mode = 1
local points_mode = 1

function SWEP:Initialize()
	self:SetNWInt("can_reload_i", 1)
	self:SetNWInt("t_running",0)
end

function SWEP:Deploy()
    self.Switched = true
	self.Owner:PrintMessage( HUD_PRINTCENTER, "Give Mode" )
    return BaseClass.Deploy(self)
end

function SWEP:PrimaryAttack()
    BaseClass.PrimaryAttack(self)
	local tr = self.Owner:GetEyeTrace().Entity
	if !tr:IsValid() then return end
	if tr:GetPos():Distance( self.Owner:GetPos() ) > self.Primary.Distance then return end
	if not tr:IsPlayer() then return end
	if SERVER then
		if table.HasValue(hpconfig.gryffindor, tr:Team()) then
			if mode == 1 then
			SetGlobalInt("ge_points", GetGlobalInt("ge_points")+points_mode)
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " gave " .. points_mode .. " points to " .. "Gryffindor")
			end
			elseif mode == 2 then
			if GetGlobalInt("ge_points") - points_mode < 0 then
			SetGlobalInt("ge_points", 0)
			else
			SetGlobalInt("ge_points", GetGlobalInt("ge_points")-points_mode)
			end
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " took " .. points_mode .. " points from " .. "Gryffindor")
			end
			end
		elseif table.HasValue(hpconfig.hufflepuff, tr:Team()) then
			if mode == 1 then
			SetGlobalInt("he_points", GetGlobalInt("he_points")+points_mode)
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " gave " .. points_mode .. " points to " .. "Hufflepuff")
			end
			elseif mode == 2 then
			if GetGlobalInt("he_points") - points_mode < 0 then
			SetGlobalInt("he_points", 0)
			else
			SetGlobalInt("he_points", GetGlobalInt("he_points")-points_mode)
			end
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " took " .. points_mode .. " points from " .. "Hufflepuff")
			end
			end
		elseif table.HasValue(hpconfig.ravenclaw, tr:Team()) then
			if mode == 1 then
			SetGlobalInt("re_points", GetGlobalInt("re_points")+points_mode)
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " gave " .. points_mode .. " points to " .. "Ravenclaw")
			end
			elseif mode == 2 then
			if GetGlobalInt("re_points") - points_mode < 0 then
			SetGlobalInt("re_points", 0)
			else
			SetGlobalInt("re_points", GetGlobalInt("re_points")-points_mode)
			end
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " took " .. points_mode .. " points from " .. "Ravenclaw")
			end
			end
		elseif table.HasValue(hpconfig.slytherin, tr:Team()) then
			if mode == 1 then
			SetGlobalInt("se_points", GetGlobalInt("se_points")+points_mode)
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " gave " .. points_mode .. " points to " .. "Slytherin")
			end
			elseif mode == 2 then
			if GetGlobalInt("se_points") - points_mode < 0 then
			SetGlobalInt("se_points", 0)
			else
			SetGlobalInt("se_points", GetGlobalInt("se_points")-points_mode)
			end
			for k,v in pairs(player.GetAll()) do
				DarkRP.notify(v, 1, 4, self.Owner:Name() .. " took " .. points_mode .. " points from " .. "Slytherin")
			end
			end
		else
			return
		end
	end
end
function SWEP:Reload()
	if points_mode == 1 and self:GetNWInt("can_reload_i") == 1 then
		points_mode = 10
		self:SetNWInt("can_reload_i", 0)
	elseif points_mode == 10 and self:GetNWInt("can_reload_i") == 1 then
		points_mode = 25
		self:SetNWInt("can_reload_i", 0)
	elseif points_mode == 25 and self:GetNWInt("can_reload_i") == 1 then
		points_mode = 50
		self:SetNWInt("can_reload_i", 0)
	elseif points_mode == 50 and self:GetNWInt("can_reload_i") == 1 then
		points_mode = 100
		self:SetNWInt("can_reload_i", 0)
	elseif points_mode == 100 and self:GetNWInt("can_reload_i") == 1 then
		points_mode = 1
		self:SetNWInt("can_reload_i", 0)
	end
	if self:GetNWInt("can_reload_i") == 0 and self:GetNWInt("t_running") == 0 then
		self:SetNWInt("t_running", 1)
	timer.Create("_reload_i", .25, 0, function()
		self:SetNWInt("can_reload_i", 1)
		self:SetNWInt("t_running",0)
	end)
	end
	self.Owner:PrintMessage( HUD_PRINTCENTER, "Points:" .. points_mode)
end
function SWEP:SecondaryAttack()
	if mode == 1 then
		mode = 2
		self:SetNextSecondaryFire(CurTime()+1)
	elseif mode == 2 then
		mode = 1
		self:SetNextSecondaryFire(CurTime()+1)
	end
	if mode == 1 then
	self.Owner:PrintMessage( HUD_PRINTCENTER, "Give Mode" )
	elseif mode == 2 then
	self.Owner:PrintMessage( HUD_PRINTCENTER, "Take Mode")
	end
end


