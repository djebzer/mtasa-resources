local warps = {}
local backupWarp = nil
local nitroUpgrades = {
	[1008] = true,
	[1009] = true,
	[1010] = true,
}

function createWarp()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (not vehicle) then
		outputChatBox('[warps] You must be in a vehicle!', 255, 0, 0)
		return
	end

	if (not warps) then
		warps = {}
	end

	local vehicleModel = getElementModel(vehicle)
	local vehicleHealth = getElementHealth(vehicle)
	local x, y, z = getElementPosition(vehicle)
	local rX, rY, rZ = getElementRotation(vehicle)
	local vX, vY, vZ = getElementVelocity(vehicle)
	local aX, aY, aZ = getElementAngularVelocity(vehicle)
	
	local hasNitro = false
	local nitroUpgrade = getVehicleUpgradeOnSlot(vehicle, 8)
	local nitroLevel = 0
	local isNitroActivated = false
	if (nitroUpgrades[nitroUpgrade]) then
		hasNitro = true
		nitroLevel = getVehicleNitroLevel(vehicle)
		if (isVehicleNitroActivated(vehicle)) then
			isNitroActivated = true
		end
	end

	-- Save the warp
	table.insert(warps, {
		vehicleModel = vehicleModel,
		vehicleHealth = vehicleHealth,
		x = x,
		y = y,
		z = z,
		rX = rX,
		rY = rY,
		rZ = rZ,
		vX = vX,
		vY = vY,
		vZ = vZ,
		aX = aX,
		aY = aY,
		aZ = aZ,
		hasNitro = hasNitro,
		nitroUpgrade = nitroUpgrade,
		nitroLevel = nitroLevel,
		isNitroActivated = isNitroActivated,
	})
	outputChatBox('[warps] Warp #'..#warps..' has been saved!', 0, 255, 0)
end
addCommandHandler('sw', createWarp)

function loadWarp(cmd, index)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (not vehicle) then
		outputChatBox('[warps] You must be in a vehicle!', 255, 0, 0)
		return
	end

	if (not warps) or (#warps < 1) then
		outputChatBox('[warps] You don\'t have any warps saved! (use /sw)', 255, 0, 0)
		return
	end

	local warp = warps[#warps]
	local loadedIndex = #warps
	if (index) and (warps[tonumber(index)]) then
		warp = warps[tonumber(index)]
		loadedIndex = tonumber(index)
	end

	if (not warp) then
		outputChatBox('[warps] You don\'t have any warps saved! (use /sw)', 255, 0, 0)
		return
	end

	-- Apply warp data
	setElementFrozen(vehicle, true)
	if (warp.vehicleModel ~= getElementModel(vehicle)) then
		setElementModel(vehicle, warp.vehicleModel)
	end
	setElementHealth(vehicle, warp.vehicleHealth)
	setElementPosition(vehicle, warp.x, warp.y, warp.z)
	setElementRotation(vehicle, warp.rX, warp.rY, warp.rZ)
	setCameraTarget(localPlayer)
	
	setTimer(function()
		if (isElement(vehicle)) then
			setElementFrozen(vehicle, false)
			setElementVelocity(vehicle, warp.vX, warp.vY, warp.vZ)
			setElementAngularVelocity(vehicle, warp.aX, warp.aY, warp.aZ)

			local nitroUpgrade = getVehicleUpgradeOnSlot(vehicle, 8)
			if (nitroUpgrades[nitroUpgrade]) then
				removeVehicleUpgrade(vehicle, nitroUpgrade)
			end

			if (warp.hasNitro) then
				addVehicleUpgrade(vehicle, warp.nitroUpgrade)
				setVehicleNitroLevel(vehicle, warp.nitroLevel)
				if (warp.isNitroActivated) then
					setVehicleNitroActivated(vehicle, true)
				end
			end
		end
	end, 300, 1)

	outputChatBox('[warps] Warp #'..loadedIndex..' has been loaded!', 0, 255, 0)
end
addCommandHandler('lw', loadWarp)

function deleteWarp(cmd, index)
	if (not warps) or (#warps < 1) then
		outputChatBox('[warps] You don\'t have any warps saved! (use /sw)', 255, 0, 0)
		return
	end

	local warp = warps[#warps]
	local deletedIndex = #warps

	if (index) and (warps[tonumber(index)]) then
		warp = warps[tonumber(index)]
		deletedIndex = tonumber(index)
	end

	if (not warp) or (#warps < 1) then
		outputChatBox('[warps] You don\'t have any warps! (use /sw)', 255, 0, 0)
		return
	end

	if (not warp) then
		outputChatBox('[warps] Couldn\'t delete this warp because it doesn\'t exist!', 255, 0, 0)
		return
	end

	backupWarp = warps[deletedIndex] -- Backup the warp for recover
	table.remove(warps, deletedIndex)
	outputChatBox('[warps] Warp #'..deletedIndex..' has been deleted! (Use /rw to recover it)', 255, 0, 0)
end
addCommandHandler('dw', deleteWarp)

function recoverWarp()
	if (not backupWarp) then
		outputChatBox('[warps] You don\'t have any warp to recover!', 255, 0, 0)
		return
	end
	table.insert(warps, backupWarp)
	outputChatBox('[warps] Latest warp has been recovered!', 0, 255, 0)
end
addCommandHandler('rw', recoverWarp)

function deleteAllWarps()
	if (not warps) or (#warps < 1) then
		outputChatBox('[warps] You don\'t have any warps! (use /sw)', 255, 0, 0)
		return
	end
	warps = {}
	outputChatBox('[warps] You deleted all your warps!', 255, 190, 0)
end
addCommandHandler('daw', deleteAllWarps)