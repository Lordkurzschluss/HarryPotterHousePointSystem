local hideHUDElements = {
	["DarkRP_HUD"] = false,

	["DarkRP_EntityDisplay"] = false,

	["DarkRP_LocalPlayerHUD"] = false,

	["DarkRP_Hungermod"] = false,

	["DarkRP_Agenda"] = false,

	["DarkRP_LockdownHUD"] = false,

	["DarkRP_ArrestedHUD"] = false,
}
surface.CreateFont( "hpFont", {
	font = "Gabriola", 
	extended = false,
	size = 300,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )
hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)

local function hudPaint()
	if show_points == true then
	_p = LocalPlayer()
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("gemblem.png"))
	surface.DrawTexturedRect( ScrW()/2-400, 0, 128, 128 )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("hemblem.png"))
	surface.DrawTexturedRect( ScrW()/2-200, 0, 128, 128 )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("remblem.png"))
	surface.DrawTexturedRect( ScrW()/2, 0, 128, 128 )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("semblem.png"))
	surface.DrawTexturedRect( ScrW()/2+200, 0, 128, 128 )
	if GetGlobalInt("ge_points") < 10 then
	draw.SimpleText( GetGlobalInt("ge_points"), "hpFont", ScrW()/2-350, 100, Color( 116, 0, 0, 255 ))
	elseif GetGlobalInt("ge_points") <= 99 then
	draw.SimpleText( GetGlobalInt("ge_points"), "hpFont", ScrW()/2-360, 100, Color( 116, 0, 0, 255 ))
	elseif GetGlobalInt("ge_points") <= 999 and GetGlobalInt("ge_points") > 99 then
	draw.SimpleText( GetGlobalInt("ge_points"), "hpFont", ScrW()/2-375, 100, Color( 116, 0, 0, 255 ))
	else
	draw.SimpleText( GetGlobalInt("ge_points"), "hpFont", ScrW()/2-385, 100, Color( 116, 0, 0, 255 ))
	end
	if GetGlobalInt("he_points") < 10 then
	draw.SimpleText( GetGlobalInt("he_points"), "hpFont", ScrW()/2-150, 100, Color( 236, 185, 57, 255 ))
	elseif GetGlobalInt("he_points") <= 99 then
	draw.SimpleText( GetGlobalInt("he_points"), "hpFont", ScrW()/2-160, 100, Color( 236, 185, 57, 255 ))
	elseif GetGlobalInt("he_points") <= 999 then
	draw.SimpleText( GetGlobalInt("he_points"), "hpFont", ScrW()/2-175, 100, Color( 236, 185, 57, 255 ))
	else
	draw.SimpleText( GetGlobalInt("he_points"), "hpFont", ScrW()/2-180, 100, Color( 236, 185, 57, 255 ))
	end
	if GetGlobalInt("re_points") < 10 then
	draw.SimpleText( GetGlobalInt("re_points"), "hpFont", ScrW()/2+50, 100, Color( 14, 26, 64, 255 ))
	elseif GetGlobalInt("re_points") <= 99 then
	draw.SimpleText( GetGlobalInt("re_points"), "hpFont", ScrW()/2+35, 100, Color( 14, 26, 64, 255 ))
	elseif GetGlobalInt("re_points") <= 999 then
	draw.SimpleText( GetGlobalInt("re_points"), "hpFont", ScrW()/2+20, 100, Color( 14, 26, 64, 255 ))
	else
	draw.SimpleText( GetGlobalInt("re_points"), "hpFont", ScrW()/2+10, 100, Color( 14, 26, 64, 255 ))
	end
	if GetGlobalInt("se_points") < 10 then
	draw.SimpleText( GetGlobalInt("se_points"), "hpFont", ScrW()/2+250, 100, Color( 26, 71, 42, 255 ))
	elseif GetGlobalInt("re_points") <= 99 then
	draw.SimpleText( GetGlobalInt("se_points"), "hpFont", ScrW()/2+235, 100, Color( 26, 71, 42, 255 ))
	elseif GetGlobalInt("se_points") <= 999 then
	draw.SimpleText( GetGlobalInt("se_points"), "hpFont", ScrW()/2+220, 100, Color( 26, 71, 42, 255 ))
	else
	draw.SimpleText( GetGlobalInt("se_points"), "hpFont", ScrW()/2+210, 100, Color( 26, 71, 42, 255 ))
	end
	end
end
hook.Add("HUDPaint", "DarkRP_Mod_HUDPaint", hudPaint)

local function pointsMenu()
	_pm = vgui.Create( "DFrame" )
	_pm:SetSize(250,125)
	_pm:SetTitle("House Point Control")
	_pm:Center()
	_pm:MakePopup()
	_pm:SetBackgroundBlur(true)
	_pm.Paint = function( self, w, h )
	  draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 130 ) )
	end
	_pm_h_s = vgui.Create( "DComboBox", _pm )
	_pm_h_s:SetSize(250,25)
	_pm_h_s:SetValue("Select House")
	_pm_h_s:AddChoice("Gryffindor")
	_pm_h_s:AddChoice("Slytherin")
	_pm_h_s:AddChoice("Ravenclaw")
	_pm_h_s:AddChoice("Hufflepuff")
	_pm_h_s:SetPos(0,25)
	_pm_h_n = vgui.Create( "DComboBox", _pm )
	_pm_h_n:SetSize(250,25)
	_pm_h_n:SetValue("Points to Give")
	_pm_h_n:AddChoice("10 Points")
	_pm_h_n:AddChoice("25 Points")
	_pm_h_n:AddChoice("50 Points")
	_pm_h_n:AddChoice("100 Points")
	_pm_h_n:SetPos(0,50)
	_pm_h_g = vgui.Create( "DButton", _pm )
	_pm_h_g:SetSize(250,25)
	_pm_h_g:SetPos(0,75)
	_pm_h_g:SetText("Give")
	_pm_h_g.DoClick = function()
		if _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Gryffindor" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(10, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(25, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(50, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(100, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		elseif _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Ravenclaw" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(10, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(25, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(50, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(100, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		elseif _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Hufflepuff" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(10, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(25, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(50, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(100, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		elseif _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Slytherin" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(10, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(25, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(50, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(100, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		else
			LocalPlayer():ChatPrint("Invalid House Selected!")
		end
	end
	_pm_h_t = vgui.Create( "DButton", _pm )
	_pm_h_t:SetSize(250,25)
	_pm_h_t:SetPos(0,100)
	_pm_h_t:SetText("Take")
	_pm_h_t.DoClick = function()
			if _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Gryffindor" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(-10, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(-25, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(-50, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(-100, 16)
				net.WriteString("ge_points")
				net.SendToServer()
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		elseif _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Ravenclaw" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(-10, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(-25, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(-50, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(-100, 16)
				net.WriteString("re_points")
				net.SendToServer()			
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		elseif _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Hufflepuff" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(-10, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(-25, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(-50, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(-100, 16)
				net.WriteString("he_points")
				net.SendToServer()			
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		elseif _pm_h_s:GetOptionText(_pm_h_s:GetSelectedID()) == "Slytherin" then
			if _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "10 Points" then
				net.Start("pointsMath")
				net.WriteInt(-10, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "25 Points" then
				net.Start("pointsMath")
				net.WriteInt(-25, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "50 Points" then
				net.Start("pointsMath")
				net.WriteInt(-50, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			elseif _pm_h_n:GetOptionText(_pm_h_n:GetSelectedID()) == "100 Points" then
				net.Start("pointsMath")
				net.WriteInt(-100, 16)
				net.WriteString("se_points")
				net.SendToServer()			
			else
				LocalPlayer():ChatPrint("Invalid Amount Selected!")
			end
		else
			LocalPlayer():ChatPrint("Invalid House Selected!")
		end
	end
end
local function closePointsHUD()
	if input.IsKeyDown(KEY_H) then
		if show_points == false then
			show_points = true
		end
	else
		show_points = false
	end
end
net.Receive( "openPointsMenu", function( len, ply )
	 pointsMenu()
end )
hook.Add("Think", "closePointsHUD", closePointsHUD)