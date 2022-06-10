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
--      Turbolift Entry | Server     --
---------------------------------------
-----------------------

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.IsTurbolift = true

function ENT:SpawnFunction(ply, tr, ClassName)
	if not tr.Hit then return end

	local pos = tr.HitPos
	local ang = ply:GetAngles()

	pos = pos + Vector(0, 0, 64)

	ang.p = 0
	ang.r = 0
	ang = ang + Angle(0, 180, 0)

	local parent = ents.Create("prop_physics")
	parent:SetPos(pos)
	parent:SetAngles(ang)
	parent:SetModel("models/kingpommes/startrek/intrepid/turbolift_main.mdl")
	parent:Spawn()
	parent:Activate()

	local phys = parent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	local ent = ents.Create(ClassName)
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:SetParent(parent)
	ent:Spawn()
	ent:Activate()

	undo.AddEntity(parent)

	return ent
end

function ENT:Initialize()
	self:SetModel("models/kingpommes/startrek/intrepid/turbolift_button.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	local turboliftData = {
		Name = self:GetTurboliftName(),
		ShipId = self:GetShipId(),
		Entity = self,
		InUse = false,
		Queue = {},
		LeaveTime = 0,
		ClosingTime = 0,
		CloseCallback = nil
	}
	self.TurboliftData = turboliftData

	table.insert(Star_Trek.Turbolift.Lifts, turboliftData)
	table.SortByMember(Star_Trek.Turbolift.Lifts, "Name", true)
end

function ENT:OnRemove()
	local parent = self:GetParent()
	if IsValid(parent) then
		parent:Remove()
	end

	table.RemoveByValue(Star_Trek.Turbolift.Lifts, self.TurboliftData)
end

function ENT:Use(ply)
	Star_Trek.LCARS:OpenInterface(ply, self, "turbolift")
end

function ENT:OnVarChanged(name, old, new)
	hook.Run("Star_Trek.Turbolift_Entity.OnVarChanged", self, name, old, new)
end