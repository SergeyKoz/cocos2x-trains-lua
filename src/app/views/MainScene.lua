
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()

     local visibleSize = cc.Director:getInstance():getVisibleSize()

	 local function createRailMap()
        local railMapLayer = cc.Layer:create()
        Resources:Instance():setObject("rails_layer", railMapLayer)

        --local draw = cc.DrawNode:create()

        require "project.testing"
        --require "testing"
        --[[
        streak = cc.MotionStreak:create(10, 1, 10, cc.c3b(255, 255, 255), "__icon.png")
        railMapLayer:addChild(streak)
        streak:setPosition(cc.p(visibleSize.width / 2, visibleSize.height / 2))
        streak:setFastMode(true)
        ]]--
        for c = 1, #Game.Trains do
            Game.Trains[c]:Init()
        end
        
        -- normal move
        local function tick()
            local Trains = GameField:Instance().Trains
            --local x
            --local x = os.clock()              
            for c = 1, #Trains do
                --x = os.clock() 
                Trains[c]:Move() 
                --print(string.format("Train ".. c .. ": %.2f\n", os.clock() - x))                
            end
            
            --print(string.format("elapsed time: %.2f\n", os.clock() - x))
        end 
        
        cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick, 0.2, false)
        
        --local Elements = Elements:new()
               
        -- handing touch events
        local touchBeginPoint = nil		
        local touchMode = Move		
		local StartPoint

        local function onTouchBegan(x, y)
            cclog("onTouchBegan: %0.2f, %0.2f", x, y)            
            local cx, cy = railMapLayer:getPosition()             
            if Game.ConstructionMode == ConstructionRails then
                cx=math.floor((-cx + x) / (GameField.Scale * 10) + 0.5)
                cy=math.floor((-cy + y) / (GameField.Scale * 10) + 0.5)
                StartPoint=Path:InitPath(cx, cy)                
                if StartPoint ~= nil then
                    touchMode = BuildRails
                    --local x = os.clock()
                    --print(string.format("elapsed time: %.2f\n", os.clock() - x))				
                end
            end            
            if Game.ConstructionMode == ConstructionSemafores then                
                local px=math.floor((-cx + x) / (GameField.Scale * 10) + 0.5)
                local py=math.floor((-cy + y) / (GameField.Scale * 10) + 0.5)                
                if Semaphore:Show(px, py, px - ((-cx + x) / (GameField.Scale * 10)) , py - ((-cy + y) / (GameField.Scale * 10))) then
                    touchMode = SemaphoreShow
                end                
            end			
            touchBeginPoint = {x = x, y = y}            
            -- CCTOUCHBEGAN event must return true
            return true
        end

        local function onTouchMoved(x, y)
            cclog("onTouchMoved: %0.2f, %0.2f", x, y)
            if touchBeginPoint then
                local cx, cy = railMapLayer:getPosition()				
				local px, py                
                if touchMode == Move then
					px = cx + x - touchBeginPoint.x
					py = cy + y - touchBeginPoint.y					
					if px > 0 then
						px = 0
					end					
					if py > 0 then
						py = 0
					end
					railMapLayer:setPosition(px, py)                               
				end                
                if touchMode == BuildRails or touchMode == SemaphoreShow then
                    px=math.floor((-cx + x) / (GameField.Scale * 10)+0.5)
                    py=math.floor((-cy + y) / (GameField.Scale * 10)+0.5)                    
                    if touchMode == BuildRails then                        
                        Path:Show(px, py)
                    end                
                    if touchMode == SemaphoreShow then
                        if not Semaphore:Show(px, py, px - ((-cx + x) / (GameField.Scale * 10)) , py - ((-cy + y) / (GameField.Scale * 10))) then
                            Semaphore:Hide(px, py)
                        end
                    end
                end                
				touchBeginPoint = {x = x, y = y}				
            end
        end

        local function onTouchEnded(x, y)
			--streak:setPosition( cc.p(x, y))
			if touchMode == BuildRails then
				Path:Set()
			end            
            if touchMode == SemaphoreShow then
                Semaphore:Set()             
            end			
			touchMode = Move
            cclog("onTouchEnded: %0.2f, %0.2f", x, y)
            touchBeginPoint = nil           
        end
		
		local function onTouch(eventType, x, y)            
            if eventType == "began" then   
                return onTouchBegan(x, y)
            elseif eventType == "moved" then
                return onTouchMoved(x, y)
            else
                return onTouchEnded(x, y)
            end
        end

        railMapLayer:registerScriptTouchHandler(onTouch)
        railMapLayer:setTouchEnabled(true)
		
		return railMapLayer
	end 
    
    local function createRailMapBackGround()
		local backGroundLayer = cc.Layer:create()
		local bg = cc.LayerColor:create(cc.c4b(255,255,255,255))
		backGroundLayer:addChild(bg)
		return backGroundLayer
	end
    
    local function createMenu()
		local MenuLayer = cc.Layer:create()
        Resources:Instance():setObject("menu_layer", MenuLayer)
        
        Menu:new(visibleSize)
        
		return MenuLayer
	end

	self:addChild(createRailMapBackGround())
    self:addChild(createRailMap())   
    self:addChild(createMenu())   

    -- add background image
    --[[display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self) ]]--

end

return MainScene
