# 🎵 music
Want to add a song on your map? Simply add this file in your map and make sure you edit the `songPath` variable at the top of the file if your file name/path is different.

## How to install
1. Put the `music.lua` file inside your map resource.
2. Add an mp3 file inside the map resource, name it `song.mp3`.
3. Add these lines inside your `meta.xml` file:
```xml
<meta>
  <script src='music.lua' type='client' /> <!-- just add this line -->
  <file src='song.mp3'> <!-- and this one -->
  <!-- other content... -->
</meta>
```
Make sure the paths to the files are correct.

## Help
Don't know how to deal with paths?

If your song file is inside the root folder of your map:
```
└── map/
  ├── yourMap.map
  ├── meta.xml
  ├── music.lua
  └── song.mp3*
```

Leave it like this:

```lua
local songPath = 'song.mp3'
```

If your song file is inside a sub folder: 

```
└── map/
  ├── some-folder/
  │   └── song.mp3*
  ├── yourMap.map
  ├── meta.xml
  └── music.lua
```

Make sure you add the sub folder name at the beginning of the path:
```lua
local songPath = 'some-folder/song.mp3'
```