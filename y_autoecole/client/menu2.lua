------- Yamsoo Scripts -------
--- discord.gg/WqDvPcCw3S ---
-----------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end
end)


local yamsoo_autoecol = RageUI.CreateMenu('Auto Ecole', '')
ESX                     = nil
user = {}
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint = 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local DriveErrors       = 0
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

function OpenMenutest()
	if open then 
		open = false
		RageUI.Visible(yamsoo_autoecol, false)
		return
	else
		open = true 
		RageUI.Visible(yamsoo_autoecol, true)
		CreateThread(function()
		while open do 
			RageUI.IsVisible(yamsoo_autoecol, function() 

				RageUI.Separator('')
				RageUI.Separator('~b~↓ ~s~Examen Disponible~b~↓')


			RageUI.Button("Passer le Permis ~b~Voiture", nil, {RightLabel = "→"}, true, {
				onSelected = function()
					TriggerServerEvent('paytonpermis')
					StartDriveTest()
					ESX.ShowAdvancedNotification('SukiRP', '~b~Moniteur', "Bonjour, je serais ton Moniteur aujourd'hui. Tu peut déja te dirigé vers le premier passage.", 'CHAR_HUNTER', 7)
					RageUI.CloseAll()				
				end
			})

			RageUI.Separator('~b~↓ ~s~Prix du Permis~b~↓')
			RageUI.Separator('~g~'..Config.Prix..' $')


								

			end)
		Wait(0)
		end
	end)
  	end
end

local position = {
	{x = 228.37, y = 373.51, z = 106.11} 
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 3.0 then
            wait = 0
            DrawMarker(22, 228.37, 373.51, 106.11, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 136, 255, 255, 255, true, true, p19, true) 
			

        
            if dist <= 10.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour passer le ~b~Permis", 1) 
                if IsControlJustPressed(1,51) then
					OpenMenutest()
            end
    end
else RageUI.CloseAll()
    end
    Citizen.Wait(wait)
    end
end
end)


function StartDriveTest(type) 


	ESX.Game.SpawnVehicle('issi2', Config.yamsoospawn, Config.yamsoospawn.h, function(vehicle)
		CurrentTest       = 'drive'
		CurrentTestType   = drive
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)

end


function StopDriveTest(success)
	if success then
		TriggerServerEvent('yamsoo_autoecol:ajoutlicense', 'drive')
		ESX.ShowAdvancedNotification('SukiRP', '~b~Moniteur', "~g~Vous avez reussi le Permis, Bravo !", 'CHAR_HUNTER', 7)
	else
		ESX.ShowAdvancedNotification('SukiRP', '~b~Moniteur', "~r~Vous n'avez pas reussi le Permis !", 'CHAR_HUNTER', 7)
	end
end

function SetCurrentZoneType(type)
	CurrentZoneType = type
end

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb()
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)




function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end






Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'drive' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowAdvancedNotification('SukiRP', '~b~Moniteur', "Test de conduite terminé.", 'CHAR_HUNTER', 7)

				if DriveErrors < 5 then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(20, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 1, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'drive' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * 3.6
				local tooMuchSpeed = false

				for k,v in pairs(Config.vitessemax) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							ESX.ShowAdvancedNotification('SukiRP', '~b~Moniteur', "Tu roule ~r~trop vite~s~, Vitesse Limite: ~y~" ..v.. " ~s~km/h", 'CHAR_HUNTER', 7)
							ESX.ShowNotification('Erreurs: ~r~' ..DriveErrors.. '~s~/5')
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					ESX.ShowAdvancedNotification('SukiRP', '~b~Moniteur', "Tu à ~r~endommagé ~s~notre véhicule", 'CHAR_HUNTER', 7)
					ESX.ShowNotification('Erreurs: ~r~' ..DriveErrors.. '~s~/5')

					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(228.37, 373.51, 106.11)

    SetBlipSprite (blip, 76) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.65) -- Taille du blip
    SetBlipColour (blip, 3) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Auto-école') 
    EndTextCommandSetBlipName(blip)
end)