require("main_engine")
require("scene manager")

local game = {}

function love.load()
    game.locationMod = {x = 0, y = 0} -- makes it possible to have the player always in the center of the screen
    game.screen = {
        intended = {width = 1024, height = 768},
        shaders = {}
    }
    game.screen.mod = {width = love.graphics.getWidth() / game.screen.intended.width, height = love.graphics.getHeight() / game.screen.intended.height}
    game.state = "starting"
    game.stage = 1
    engine.load()
end

function love.update(dt)
 engine.update(dt)
end

function love.draw()

end