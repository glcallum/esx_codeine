Config              = {}
Config.MarkerType   = 1
Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 5.0, y = 5.0, z = 3.0}
Config.MarkerColor  = {r = 100, g = 204, b = 100}

Config.RequiredCopsCode  = 0 

Config.TimeToFarm    = 4 * 1000 -- 4 seconds by default. Change 4 to desired ammount of seconds
Config.TimeToProcess = 5 * 1000
Config.TimeToSell    = 6  * 1000

Config.Locale = 'en'

Config.Zones = {
	CodeField =			{x = -1154.63,	y = -2031.4,	z = 12.16},
	CodeProcessing =	{x = -1147.09,	y = -2039.83,	z = 12.16},
	CodeDealer =		{x = -1161.32,	y = -1099.98,	z = 2,	name = _U('code_dealer'),		sprite = 500,	color = 75}
}