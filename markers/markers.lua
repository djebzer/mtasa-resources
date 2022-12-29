local markers = {
	marker1 = { x = 0, y = 0, z = 0, type = 'corona', size = 10, r = 255, g = 255, b = 255, a = 255,
		callback = function(vehicle)
      if (not isVehicleReversing(vehicle)) then
        blowVehicle(vehicle)
      end
		end
	},

  marker2 = { x = 0, y = 0, z = 0, type = 'corona', size = 10, r = 255, g = 255, b = 255, a = 255,
		callback = function(vehicle)
      local speed = getElementSpeed(vehicle, 'km/h')
      if (speed < 200) then
        setElementSpeed(vehicle, 'kph', 300)
      end
		end
	},
}

-- markers handler
function loadMarkers()
	for i, m in pairs(markers) do
		if (not m.callback) then return end

		local marker = createMarker(m.x, m.y, m.z, m.type, m.size, m.r, m.g, m.b, m.a)
		if (isElement(marker)) then
      addEventHandler('onClientMarkerHit', marker, function(player, matchingDimension)
        if (matchingDimension) and (player == localPlayer) then
          local vehicle = getPedOccupiedVehicle(player)
          if (isElement(vehicle)) then
            m.callback(vehicle)
          end
        end
      end)
    end
	end
end
addEventHandler('onClientResourceStart', resourceRoot, loadMarkers)

-- util functions
-- https://wiki.multitheftauto.com/wiki/IsVehicleReversing
function isVehicleReversing(theVehicle)
  local getMatrix = getElementMatrix(theVehicle)
  local getVelocity = Vector3(getElementVelocity(theVehicle))
  local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3]) 
  if (getVectorDirection >= 0) then
    return false
  end
  return true
end

-- https://wiki.multitheftauto.com/wiki/GetElementSpeed
function getElementSpeed(element, unit)
  if (unit == nil) then unit = 15 end
  if (isElement(element)) then
    local x,y,z = getElementVelocity(element)
    if (unit == 'mph' or unit == 1 or unit == '1') then
      return (x^2 + y^2 + z^2) ^ 0.5 * 100
    else
      return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
    end
  else
    return false
  end
end

-- https://wiki.multitheftauto.com/wiki/SetElementSpeed
function setElementSpeed(element, unit, speed)
  if (unit == nil) then unit = 0 end
  if (speed == nil) then speed = 0 end
  speed = tonumber(speed)
  local acSpeed = getElementSpeed(element, unit)
  if (acSpeed ~= false) then
    local diff = speed/acSpeed
    local x, y, z = getElementVelocity(element)
    setElementVelocity(element, x*diff, y*diff, z*diff)
    return true
  end
  return false
end