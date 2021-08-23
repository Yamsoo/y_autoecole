Config                 = {}



Config.Prix = 85000 -- Prix Permis

Config.vitessemax = { --Vitesse Max selon l'endroit
	residence = 50,
	town      = 80,
	freeway   = 120
}

Config.yamsoospawn  = {x = 218.409, y = 377.230, z = 106.4094, h = 156.0} -- Spwan Véhicule 


Config.CheckPoints = {

	{
		Pos = {x = 197.139, y = 365.731, z = 107.537},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage! Vitesse limite: ~y~50~s~ km/h', 5000)
		end
	},

	{
		Pos = {x = 84.874, y = 333.574, z = 111.932},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
		end
	},

	{
		Pos = {x = 35.907, y = 278.385, z = 108.542},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText('~r~Moniteur : ~s~Faite rapidement un ~r~stop~s~ pour le piéton qui ~y~traverse', 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(4000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText('~r~Moniteur : ~g~Bien !~s~ continuons !', 5000)
			end)
		end
	},

	{
		Pos = {x = -71.821, y = 293.520, z = 105.292},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')

			Citizen.CreateThread(function()
				DrawMissionText('~r~Moniteur : ~g~Bien !~s~ prenez à ~y~droite~s~ et suivez votre file', 5000)
			end)
		end
	},

	{
		Pos = {x = -152.550, y = 444.755, z = 111.725},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
		end
	},

	{
		Pos = {x = -337.542, y = 475.335, z = 110.789},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Marquez le stop pour laisser passer les véhicules !', 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = -496.143, y = 577.282, z = 120.868},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
		end
	},

	{
		Pos = {x = -476.148, y = 804.100, z = 180.704},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
		end
	},

	{
		Pos = {x = -694.790, y = 991.726, z = 237.665},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('freeway')

			DrawMissionText('~r~Moniteur : ~s~Il est temps d\'aller sur la rocade! Vitesse limite: ~y~120~s~ km/h', 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -317.237, y = 981.178, z = 232.519},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
		end
	},

	{
		Pos = {x = 142.647, y = 933.28, z = 209.109},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
		end
	},

	{
		Pos = {x = 313.29, y = 961.66, z = 209.718},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
		end
	},

	{
		Pos = {x = 269.7, y = 612.2, z = 154.718},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')
			DrawMissionText('~r~Moniteur : ~s~Entrée en ville, attention à votre vitesse! Vitesse limite: ~y~80~s~ km/h', 5000)
		end
	},

	{
		Pos = {x = 543.29, y = 249.58, z = 102.679},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Marquez le stop au ~r~feu Rouge~s~ puis prenez à droite !', 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(3000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 514.98, y = 106.27, z = 96.0},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Marquez le stop au ~r~feu Rouge~s~ puis prenez à droite !', 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(3000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 225.11, y = 196.07, z = 105.17},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Marquez le stop au ~r~feu Rouge~s~ puis prenez à droite !', 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(3000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 217.283, y = 377.329, z = 105.921},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}
}
