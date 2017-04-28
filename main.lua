
display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"
local scenes = require("scenes.scenes")
local sceneTransitionOptions =
	{
	    effect = "fade",
	    time = 400
	}
composer.gotoScene( scenes.welcomeScreen, sceneTransitionOptions )
