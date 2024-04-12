Config = {}

Config.framework = "esx" -- esx or qb
Config.newESX = true

Config.Language = "en"

Config.GPS = {
	item = "gps", -- GPS item name
	refreshtime = 2 * 1000, -- Refreshtime for any Job-Blip in seconds

	NoAccessToGPS = { -- These jobs have no access to start the GPS
		"unemployed",
	}
}

Config.Blips = {
	foot = {
		activated = true,
		sprite = 1,
		scale = 0.8,
		color = 3,
		display = 4,
		category = 7,
		shortRange = true,
	},
	car = {
		activated = true,
		sprite = 225,
		scale = 0.8,
		color = 3,
		display = 4,
		category = 7,
		shortRange = true,
	},
	boat = {
		activated = true,
		sprite = 427,
		scale = 0.8,
		color = 3,
		display = 4,
		category = 7,
		shortRange = true,
	},
	heli = {
		activated = true,
		sprite = 64,
		scale = 0.8,
		color = 3,
		display = 4,
		category = 7,
		shortRange = true,
	},
	plane = {
		activated = true,
		sprite = 423,
		scale = 0.8,
		color = 3,
		display = 4,
		category = 7,
		shortRange = true,
	},
	dead = {
		activated = true,
		sprite = 303,
		scale = 0.8,
		color = 1,
		display = 4,
		category = 7,
		shortRange = true,
	},
}

function notify(source, title, message, type)
    -- TriggerClientEvent("six", source, title, message, type, 5000)

    -- Basic ESX Notification:
    TriggerClientEvent('esx:showNotification', source, message)
end

Config.Locales = {
	['de'] = {
		["gps_notify_title"] = "GPS-Gerät",
		["gps_on"] = "Dein GPS Gerät wurde aktiviert",
		["gps_off"] = "Dein GPS Gerät wurde deaktiviert",
	},
	['en'] = {
		["gps_notify_title"] = "GPS Device",
		["gps_on"] = "Your GPS device has been activated",
		["gps_off"] = "Your GPS device has been deactivated",
	},	
}