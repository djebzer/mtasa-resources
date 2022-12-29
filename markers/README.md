# ⚪ markers
Need an easy way to create markers on your maps? This script will make it easier for you.
All you have to do is edit the `markers` table and add as many markers as you want.
The system reads the table, automatically creates the markers and adds handlers to them.

## How to install
1. Put the `markers.lua` file inside your map resource.
2. Add this line inside your `meta.xml` file:
```xml
<meta>
  <script src='markers.lua' type='client' />
  <!-- other content... -->
</meta>
```

## Example
To create a new marker, add a new entry in the `markers` table.

```lua
  yourMarkerName = { x = 0, y = 0, z = 0, type = 'corona', size = 10, r = 255, g = 255, b = 255, a = 255,
    callback = function(vehicle)
      if (not isVehicleReversing(vehicle)) then
        blowVehicle(vehicle)
      end
    end
  },
```

`x`: X axis. (float)</br>
`y`: Y axis. (float)</br>
`z`: Z axis. (float)</br>
`type`: Marker type. (string)</br>
`size`: Marker size. (number)</br>
`r`: Red. (number)</br>
`g`: Green. (number)</br>
`b`: Blue. (number)</br>
`a`: Alpha. (number)</br>
`callback`: Callback function that will be triggered when the player (vehicle) will hit the marker. The `vehicle` variable is also accessible inside this function. (function)