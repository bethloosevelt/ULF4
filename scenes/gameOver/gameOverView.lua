
local composer = require("composer")
local scene = composer.newScene()
local widget = require "widget"

-- entry point
function scene:create( event )
	-- playBackgroundMusic()
  composer.removeHidden()
	local sceneGroup = self.view
  local txt = display.newText( event.params.winner .. " is the winner", display.contentCenterX, display.contentCenterY, native.systemFont, 32 )
end


-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

return scene
