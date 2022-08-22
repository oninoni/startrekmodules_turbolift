---------------------------------------
---------------------------------------
--         Star Trek Modules         --
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
--      Turbolift Entity | Index     --
---------------------------------------

Star_Trek:RequireModules("turbolift")

Star_Trek.Turbolift_Entity = Star_Trek.Turbolift_Entity or {}

if SERVER then
	include("sv_turbolift_entity.lua")
end