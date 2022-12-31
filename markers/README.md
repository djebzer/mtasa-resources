# ⚪ markers
Need an easy way to create markers on your maps? This script will make it easier for you.
All you have to do is edit the `markers` table and add as many markers as you want.
The system reads the table, automatically creates the markers and adds handlers to them.

## How to install
1. Put the `markers.lua` file inside your map resource.
2. Add this line inside your `meta.xml` file:
```xml
<meta>
  <script src='markers.lua' type='client' /> <!-- just add this line -->
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

## Documentation
| Variable | Description | Data type |
|:----------|:--------------|:-----------|
|`x`| The x coordinate of the marker. | `float`|
|`y`| The y coordinate of the marker. | `float`|
|`z`| The z coordinate of the marker. | `float`|
|`type`| Marker type. | `string` |
|`size`| Marker size. | `number` |
|`r`| Red color level of the marker. | `number` |
|`g`| Green color level of the marker. | `number` |
|`b`| Blue color level of the marker. | `number` |
|`a`| Alpha level of the marker. | `number` |
|`callback`| Callback function that will be called when player's vehicle hits the marker. | `function` |
