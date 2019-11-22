ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingCode    = {}
local PlayersTransformingCode  = {}
local PlayersSellingCode       = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

--code
local function HarvestCode(source)

	if CopsConnected < Config.RequiredCopsCode then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCode))
		return
	end

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingCode[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local code = xPlayer.getInventoryItem('code')

			if code.limit ~= -1 and code.count >= code.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_code'))
			else
				xPlayer.addInventoryItem('code', 1)
				HarvestCode(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestCode')
AddEventHandler('esx_drugs:startHarvestCode', function()

	local _source = source

	PlayersHarvestingCode[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestCode(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestCode')
AddEventHandler('esx_drugs:stopHarvestCode', function()

	local _source = source

	PlayersHarvestingCode[_source] = false

end)

local function TransformCode(source)

	if CopsConnected < Config.RequiredCopsCode then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCode))
		return
	end
	
	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingCode[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local codeQuantity = xPlayer.getInventoryItem('code').count
			local poochQuantity = xPlayer.getInventoryItem('code_pooch').count

			if poochQuantity > 20 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif codeQuantity < 10 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_code'))
			else
				xPlayer.removeInventoryItem('code', 10)
				xPlayer.addInventoryItem('code_pooch', 1)
			
				TransformCode(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformCode')
AddEventHandler('esx_drugs:startTransformCode', function()

	local _source = source

	PlayersTransformingCode[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformCode(_source)

end)

RegisterServerEvent('esx_drugs:stopTransformCode')
AddEventHandler('esx_drugs:stopTransformCode', function()

	local _source = source

	PlayersTransformingCode[_source] = false

end)

local function SellCode(source)

	if CopsConnected < Config.RequiredCopsCode then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCode))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingCode[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('code_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('code_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 8500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_code'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 9000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_code'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 9500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_code'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 10000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_code'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 12500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_code'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 15000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_code'))
				end
				
				SellCode(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellCode')
AddEventHandler('esx_drugs:startSellCode', function()

	local _source = source

	PlayersSellingCode[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellCode(_source)

end)

RegisterServerEvent('esx_drugs:stopSellCode')
AddEventHandler('esx_drugs:stopSellCode', function()

	local _source = source

	PlayersSellingCode[_source] = false

end)

RegisterServerEvent('esx_drugs:GetUserInventory')
AddEventHandler('esx_drugs:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_drugs:ReturnInventory', 
		_source, 
		xPlayer.getInventoryItem('code').count, 
		xPlayer.getInventoryItem('code_pooch').count,
		xPlayer.job.name, 
		currentZone
	)
end)