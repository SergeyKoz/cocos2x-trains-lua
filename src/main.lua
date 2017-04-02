
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

require "project.functions"
require "project.defines"
require "project.elements"
require "project.gamefield"
require "project.objects.train"
require "project.objects.car"
require "project.objects.switch"
require "project.objects.semaphore"
require "project.objects.menu"  
require "project.elements"
require "project.path"
require "project.cmd"

cclog = function(...)
    print(string.format(...))
end

local function main()

	Game = GameField:new()    
    Resources:Instance():setImage("rails", "project/rails.png")

    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
