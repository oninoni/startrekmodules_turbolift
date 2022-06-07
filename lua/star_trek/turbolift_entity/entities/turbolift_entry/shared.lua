---------------------------------------
---------------------------------------
--        Star Trek Utilities        --
--                                   --
--            Created by             --
--       Jan 'Oninoni' Ziegler       --
--                                   --
-- This software can be used freely, --
--    but only distributed by me.    --
--                                   --
--    Copyright © 2022 Jan Ziegler   --
---------------------------------------
---------------------------------------

---------------------------------------
--      Turbolift Entry | Shared     --
---------------------------------------

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Turbolift"
ENT.Author = "Oninoni"

ENT.Category = "Star Trek"

ENT.Spawnable = true
ENT.Editable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "ShipId", {
		KeyName = "ship_id",
		Edit = {
			type = "Int",
			title = "Ship Identifier (0 is Map)",
			order = 0,
			category = "Ship Identifier",
			min = 0,
			max = 99,
		}
	})

	self:NetworkVar("Int", 1, "DeckNumber", {
		KeyName = "deck_id",
		Edit = {
			type = "Int",
			title = "Deck Number",
			order = 0,
			category = "Deck Information",
			min = 1,
			max = 99,
		}
	})

	self:NetworkVar("String", 0, "LocationName", {
		KeyName = "location_name",
		Edit = {
			type = "Generic",
			title = "Location Name",
			order = 0,
			category = "Deck Information",
			waitforenter = true,
		}
	})

	if SERVER then
		self:SetShipId(0)
		self:SetDeckNumber(1)
		self:SetLocationName("Turbolift " .. self:EntIndex())

		self:NetworkVarNotify("ShipId", self.OnVarChanged)
		self:NetworkVarNotify("DeckNumber", self.OnVarChanged)
		self:NetworkVarNotify("LocationName", self.OnVarChanged)
	end
end

function ENT:GetTurboliftName()
	local deckNumber = self:GetDeckNumber() or 1
	if deckNumber < 9 then
		deckNumber = "0" .. deckNumber
	end

	return "Deck " .. deckNumber .. " - " .. self:GetLocationName()
end