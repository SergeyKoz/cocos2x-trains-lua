Menu = {}

function Menu:new(visibleSize)
    local Elements=Elements:new()
    local d = 10 * GameField:Instance().Scale
    
    local function OnButtonTouch(touch, event)
        local target = event:getCurrentTarget()        
        print("button touch..")
        target:setOpacity(255)
    end
    
    local function OnRailsButtonTouch(touch, event)
        local target = event:getCurrentTarget()
        if Menu.RailsButton.IsEnabled and not Menu.RailsButton.IsChecked then
            print("rails button touch..")
            Menu.RailsButton:Check()
            Menu.SemaforesButton:UnCheck()
            GameField:Instance().ConstructionMode = ConstructionRails
        end
        target:setOpacity(255)
    end
    
    local function OnSemaforesButtonTouch(touch, event)
        local target = event:getCurrentTarget()
        if Menu.SemaforesButton.IsEnabled and not Menu.SemaforesButton.IsChecked then
            Menu.SemaforesButton:Check()
            Menu.RailsButton:UnCheck()
            GameField:Instance().ConstructionMode = ConstructionSemafores
            
            print("semafores button touch..")
        end        
        target:setOpacity(255)
    end
    
    local function pX(dx)
        return visibleSize.width + dx * d
    end
    
    local function pY(dy)
        return visibleSize.height + dy * d
    end
   
    self.TasksButton = MenuButton:new(pX(-1), pY(-1), {Enable = Elements:GetMenuElement(TasksButtonEnabled), Disable = Elements:GetMenuElement(TasksButtonDisabled)}, OnButtonTouch, true, true) 
    self.ZoomInButton = MenuButton:new(pX(-1), pY(-3), {Enable = Elements:GetMenuElement(ZoomInButtonEnabled), Disable = Elements:GetMenuElement(ZoomInButtonDisabled)}, OnButtonTouch, true, true)
    self.ZoomOutButton = MenuButton:new(pX(-1), pY(-5), {Enable = Elements:GetMenuElement(ZoomOutButtonEnabled), Disable = Elements:GetMenuElement(ZoomOutButtonDisabled)}, OnButtonTouch, true, true)
    self.UndoButton = MenuButton:new(pX(-5), pY(-1), {Enable = Elements:GetMenuElement(UndoButtonEnabled), Disable = Elements:GetMenuElement(UndoButtonDisabled)}, OnButtonTouch, true, true)
    self.RedoButton = MenuButton:new(pX(-3), pY(-1), {Enable = Elements:GetMenuElement(RedoButtonEnabled), Disable = Elements:GetMenuElement(RedoButtonDisabled)}, OnButtonTouch, true, true)    
    self.RailsButton = MenuButton:new(pX(-13), pY(-1), {Enable = Elements:GetMenuElement(RailsButtonEnabled), Disable = Elements:GetMenuElement(RailsButtonDisabled), CheckedEnable = Elements:GetMenuElement(RailsButtonCheckedEnabled), CheckedDisable = Elements:GetMenuElement(RailsButtonCheckedDisabled)}, OnRailsButtonTouch, true, true, true)
    self.SemaforesButton = MenuButton:new(pX(-11), pY(-1), {Enable = Elements:GetMenuElement(SemaforesButtonEnabled), Disable = Elements:GetMenuElement(SemaforesButtonDisabled), CheckedEnable = Elements:GetMenuElement(SemaforesButtonCheckedEnabled), CheckedDisable = Elements:GetMenuElement(SemaforesButtonCheckedDisabled)}, OnSemaforesButtonTouch, true, true, false)    
    self.StartButton = MenuButton:new(pX(-23), pY(-1), {Enable = Elements:GetMenuElement(StartButtonEnabled), Disable = Elements:GetMenuElement(StartButtonDisabled)}, OnButtonTouch, true, true)    
    self.PauseButton = MenuButton:new(pX(-23), pY(-1), {Enable = Elements:GetMenuElement(PauseButtonEnabled), Disable = Elements:GetMenuElement(PauseButtonDisabled)}, OnButtonTouch, true, false)    
    self.StopButton = MenuButton:new(pX(-21), pY(-1), {Enable = Elements:GetMenuElement(StopButtonEnabled), Disable = Elements:GetMenuElement(StopButtonDisabled)}, OnButtonTouch, true, false)    
    self.FastButton = MenuButton:new(pX(-19), pY(-1), {Enable = Elements:GetMenuElement(FastButtonEnabled), Disable = Elements:GetMenuElement(FastButtonDisabled)}, OnButtonTouch, true, false)
end

MenuButton = {}

function MenuButton:new(x, y, Source, OnTouchAction, IsEnabled, IsShowed, IsChecked)
    local Layer = Resources:Instance():Get('menu_layer') 
    
    Source.Enable:setPosition(x, y)
    Source.Disable:setPosition(x, y)    
    Layer:addChild(Source.Enable, MenuZIndex)    
    Layer:addChild(Source.Disable, MenuZIndex)
    
    if IsChecked == nil then       
        if not IsShowed then
            Source.Enable:setVisible(false)
            Source.Disable:setVisible(false)
        else
            Source.Enable:setVisible(IsEnabled)
            Source.Disable:setVisible(not IsEnabled)
        end
    end
    
    if IsChecked ~= nil then
        Source.CheckedEnable:setPosition(x, y)
        Source.CheckedDisable:setPosition(x, y)      
        if not IsShowed then           
            Source.Enable:setVisible(false)
            Source.Disable:setVisible(false)
            Source.CheckedEnable:setVisible(false)
            Source.CheckedDisable:setVisible(false)
        else
            if IsChecked then
                Source.Enable:setVisible(false)
                Source.Disable:setVisible(false)                
                Source.CheckedEnable:setVisible(IsEnabled)
                Source.CheckedDisable:setVisible(not IsEnabled) 
            else
                Source.Enable:setVisible(IsEnabled)
                Source.Disable:setVisible(not IsEnabled)
                Source.CheckedEnable:setVisible(false)
                Source.CheckedDisable:setVisible(false)       
            end
        end
        
        Layer:addChild(Source.CheckedEnable, MenuZIndex)    
        Layer:addChild(Source.CheckedDisable, MenuZIndex)
    end

    local function onTouchBegan(touch, event)
        local target = event:getCurrentTarget()
        
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        
        if cc.rectContainsPoint(rect, locationInNode) then
            print(string.format("sprite began... x = %f, y = %f", locationInNode.x, locationInNode.y))
            target:setOpacity(180)
            return true
        end
        return false
    end

    local function onTouchMoved(touch, event)
        --[[local target = event:getCurrentTarget()
        local posX,posY = target:getPosition()
        local delta = touch:getDelta()
        target:setPosition(cc.p(posX + delta.x, posY + delta.y))]]--
    end
    
    --[[
    local function onTouchEnded(touch, event)
        local target = event:getCurrentTarget()
        print("sprite onTouchesEnded..")
        target:setOpacity(255)        
    end
    ]]--
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(OnTouchAction,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = Layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, Source.Enable) 
    
    Object = {Source = Source, IsEnabled = IsEnabled, IsShowed = IsShowed, IsChecked = IsChecked}   
    
    self.__index = self
    return setmetatable(Object, self)
end; 

function MenuButton:Check()
    self.Source.Enable:setVisible(false)
    self.Source.CheckedEnable:setVisible(true)
    self.IsChecked = true
end

function MenuButton:UnCheck()
    self.Source.Enable:setVisible(true)
    self.Source.CheckedEnable:setVisible(false)
    self.IsChecked = false
end

function MenuButton:Show()

end

function MenuButton:Hide()

end

function MenuButton:Enable()

end

function MenuButton:Disable()

end