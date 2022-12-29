local songPath = 'song.mp3'

function startMusic()
	setRadioChannel(0)
	song = playSound(songPath, true)
end
addEventHandler('onClientResourceStart', resourceRoot, startMusic)

function makeRadioStayOff()
	setRadioChannel(0)
	cancelEvent()
end
addEventHandler('onClientPlayerRadioSwitch', root, makeRadioStayOff)
addEventHandler('onClientPlayerVehicleEnter', root, makeRadioStayOff)

function toggleSong()
	if (not songOff) then
		setSoundVolume(song, 0)
	  songOff = true
	  removeEventHandler('onClientPlayerRadioSwitch', root,makeRadioStayOff)
  else
		setSoundVolume(song, 1)
	  songOff = false
	  setRadioChannel(0)
	  addEventHandler('onClientPlayerRadioSwitch', root, makeRadioStayOff)
  end
end
addCommandHandler('music', toggleSong)
bindKey('m', 'down', 'music')