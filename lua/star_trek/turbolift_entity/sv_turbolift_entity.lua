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
--     Turbolift Entity | Server     --
---------------------------------------

hook.Add("Star_Trek.Turbolift.OverrideName", "Star_Trek.Turbolift_Entity.OverrideName", function(ent)
	if ent:GetClass() ~= "turbolift_entry" then
		return
	end

	return ent:GetTurboliftName()
end)

hook.Add("Star_Trek.Turbolift_Entity.OnVarChanged", "", function(ent, name, old, new)
	timer.Simple(0, function()
		if not IsValid(ent) then
			return
		end

		local turboLiftData = ent.Data
		if not istable(turboLiftData) then
			return
		end

		turboLiftData.Name = ent:GetTurboliftName()
		turboLiftData.ShipId = ent:GetShipId()

		table.SortByMember(Star_Trek.Turbolift.Lifts, "Name", true)
	end)
end)

hook.Add("Star_Trek.Turbolift.ExcludeTeleport", "Star_Trek.Turbolift_Entity.ExcludeTeleport", function(liftEntity, ent)
	local parent = liftEntity:GetParent()
	if not IsValid(parent) then
		return
	end

	if ent == parent then
		return true
	end

	if table.HasValue(parent:GetChildren(), ent) then
		return true
	end
end)