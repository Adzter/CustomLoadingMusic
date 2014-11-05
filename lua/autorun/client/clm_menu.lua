--[[

   _____          _                  _                     _ _             __  __           _      
  / ____|        | |                | |                   | (_)           |  \/  |         (_)     
 | |    _   _ ___| |_ ___  _ __ ___ | |     ___   __ _  __| |_ _ __   __ _| \  / |_   _ ___ _  ___ 
 | |   | | | / __| __/ _ \| '_ ` _ \| |    / _ \ / _` |/ _` | | '_ \ / _` | |\/| | | | / __| |/ __|
 | |___| |_| \__ \ || (_) | | | | | | |___| (_) | (_| | (_| | | | | | (_| | |  | | |_| \__ \ | (__ 
  \_____\__,_|___/\__\___/|_| |_| |_|______\___/ \__,_|\__,_|_|_| |_|\__, |_|  |_|\__,_|___/_|\___|
                                                                      __/ |                        
                                                                     |___/                         

-- Developed by Adzter and Alessa
-- http://steamcommunity.com/id/adzter790
-- http://steamcommunity.com/id/GreyHellios/

]]

surface.CreateFont("TitleFont", {
	font = "Default",
	size = 20,
	weight = 500
})

function MainMenu()
	local dFrame = vgui.Create("DFrame")
	dFrame:SetSize(400, 100)
	dFrame:Center()
	dFrame:MakePopup()
	dFrame:SetVisible(true)
	dFrame:ShowCloseButton(false)
	dFrame:SetTitle("")
	dFrame.Paint = function(self)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 200))
		draw.RoundedBox(0, 0, 0, self:GetWide(), 25, Color(0, 0, 0, 255))
		draw.SimpleText("Loading Screen Config", "TitleFont", self:GetWide() / 2 - 80, 0, Color(255, 255, 255))
	end
	
	local closeBtn = vgui.Create("DButton", dFrame)
	closeBtn:SetPos(dFrame:GetWide() - 25, 0)
	closeBtn:SetSize(20, 20)
	closeBtn:SetText("")
	closeBtn.DoClick = function() dFrame:SlideUp(0.5) end
	closeBtn.Paint = function(self)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 255))
		draw.SimpleText("X", "TitleFont", self:GetWide() / 2, 0, Color(255, 255, 255))
	end
	
	local urlBox = vgui.Create("DTextEntry", dFrame)
	urlBox:SetPos(20, 40)
	urlBox:SetSize(dFrame:GetWide() - 40, 20)
	
	local submit = vgui.Create("DButton", dFrame)
	submit:SetSize(dFrame:GetWide() - 40, 20)
	submit:SetPos(20, 65)
	submit:SetText("Submit Loading Screen Changes")
	submit.DoClick = function()
		net.Start('getLink')
			net.WriteString(urlBox:GetValue())
		net.SendToServer()

		dFrame:Remove()
	end
end
concommand.Add("clm_config_open", MainMenu)