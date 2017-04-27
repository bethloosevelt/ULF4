-- libs
local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"


-- our packages
music = require("music")
images = require("images")
imageTransformers = require("imageTransformers")

local nextScene = "difficultySelect"
local sceneTransitionOptions =
	{
	    effect = "fade",
	    time = 400
	}


function playBackgroundMusic()
	local backGroundSong = music.songs.backgroundMusic
	local backgroundMusic = audio.loadSound(backGroundSong.filePath)
	audio.play( backgroundMusic, {channel = backGroundSong.channel, loops = backGroundSong.loops} )
end

-- maybe have a util that builds generic buttons? is the constructor shitty enough?
function createStartGameButton()
	local startGameButton = widget.newButton{
		defaultFile = images.buttons.startGame.defaultFilePath,
        overFile = images.buttons.startGame.overFilePath,
		width=154, height=40,
		onRelease = function() composer.getScene(nextScene, sceneTransitionOptions) end
	}
	startGameButton.x = display.contentCenterX
	startGameButton.y = display.contentHeight - 125
	return startGameButton
end

function createBackgroundImage(sceneGroup)
	local logo = display.newImage( sceneGroup, images.backgrounds.startScreen.filePath, display.contentCenterX, 100)
	imageTransformers.scaleToScreenX(logo, 40) -- 40px padding on each side
	return logo
end

function scene:create( event )
	playBackgroundMusic()
	local sceneGroup = self.view
	local startGameButton = createStartGameButton()
	local backgroundImage = createBackgroundImage(sceneGroup)
	sceneGroup:insert(backgroundImage)
	sceneGroup:insert(startGameButton)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
end

function scene:destroy( event )
	local sceneGroup = self.view
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
