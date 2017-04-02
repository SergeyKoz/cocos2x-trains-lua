
Semaphore = {}

Semaphore.ShowObject = {}

function Semaphore:new(Cell, Point)
    local Elements = Elements:new()
    local Layer = Resources:Instance():Get('rails_layer')
    local Resources
    if Point == 1 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo1), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse1), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop1)}
    end
    
    if Point == 2 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo2), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse2), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop2)}
    end
    
    if Point == 3 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo3), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse3), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop3)}
    end
    
    if Point == 4 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo4), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse4), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop4)}
    end
    
    if Point == 5 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo5), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse5), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop5)}
    end
    
    if Point == 6 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo6), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse6), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop6)}
    end
    
    if Point == 7 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo7), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse7), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop7)}
    end
    
    if Point == 8 then
        Resources = {Go = Elements:GetElement(Cell.x, Cell.y, SemaforGo8), Reverse = Elements:GetElement(Cell.x, Cell.y, SemaforReverse8), Stop = Elements:GetElement(Cell.x, Cell.y, SemaforStop8)}
    end
    
    Resources.Go.CellX=Cell.x
    Resources.Go.CellY=Cell.y
    Resources.Go.CellPoint=Point
    
    Resources.Go:setVisible(true)
    Layer:addChild(Resources.Go, SemaforesZIndex)
    
    Resources.Reverse:setVisible(false)
    Layer:addChild(Resources.Reverse, SemaforesZIndex)
    
    Resources.Stop:setVisible(false)
    Layer:addChild(Resources.Stop, SemaforesZIndex)
    
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
    end
        
    local function onTouchEnded(touch, event)
        local target = event:getCurrentTarget()             
        GameField:Instance().Cells[target.CellX][target.CellY].Semaphore[target.CellPoint]:Next()
        target:setOpacity(255)        
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = Layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, Resources.Go) 
    
    Object = {Position = Go, Cell = Cell, Point = Point, Resources = Resources, Trains = {}, Schedule = {}}
    
    self.__index = self	
	return setmetatable(Object, self)    
end

function Semaphore:Show(cx, cy, dx, dy)
    local IsShow = false
    --local Object = self.ShowObject
    --local Area = self.Area
	local Game=GameField:Instance()
	local Cell = Game:getCell(cx, cy)
    local Layer = Resources:Instance():Get('rails_layer')
    local Elements = Elements:new()    
    
    local function AllowedPoint(Cell, Point)
        return Cell.Connection[Point] ~= nil and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[Point] == nil) ) and (Cell.Semaphore == nil or (Cell.Semaphore ~= nil and Cell.Semaphore[Point] == nil) );
    end
    
    if Cell.configuration==Polar or Cell.configuration==Ortogonal then
        IsShow = false
        
        local k = 1
        if GameField:Instance().TrafficSide == LeftHandTraffic then
            k = -1
        end
        
        if Cell.configuration==Ortogonal then
            --if Cell.Connection[1] ~= nil and k * dy < 0 and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[1] == nil) ) then
            if AllowedPoint(Cell, 1) and k * dy < 0 then
                if self:Hide(cx, cy, SemaforGo1) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo1, Point = 1, Image = Elements:GetElement(cx, cy, SemaforGo1)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end
            
            --if Cell.Connection[5] ~= nil and k * dy > 0 and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[5] == nil) ) then
            if AllowedPoint(Cell, 5) and k * dy > 0 then
                if self:Hide(cx, cy, SemaforGo5) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo5, Point = 5, Image = Elements:GetElement(cx, cy, SemaforGo5)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end
            
            --if Cell.Connection[3] ~= nil and k * dx > 0 and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[3] == nil) ) then
            if AllowedPoint(Cell, 3) and k * dx > 0 then
                if self:Hide(cx, cy, SemaforGo3) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo3, Point = 3, Image = Elements:GetElement(cx, cy, SemaforGo3)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end
            
            --if Cell.Connection[7] ~= nil and k * dx < 0 and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[7] == nil) ) then
            if AllowedPoint(Cell, 7) and k * dx < 0 then
                if self:Hide(cx, cy, SemaforGo7) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo7, Point = 7, Image = Elements:GetElement(cx, cy, SemaforGo7)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end
            
        end
        
        if Cell.configuration==Polar then           
            --if Cell.Connection[2] ~= nil and  - dx * k  < - dy * k and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[2] == nil) ) then
            if AllowedPoint(Cell, 2) and - dx * k  < - dy * k then
                if self:Hide(cx, cy, SemaforGo2) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo2, Point = 2, Image = Elements:GetElement(cx, cy, SemaforGo2)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end
            
            --if Cell.Connection[6] ~= nil and - dx * k  > - dy * k and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[6] == nil) ) then
            if AllowedPoint(Cell, 6) and - dx * k  > - dy * k then
                if self:Hide(cx, cy, SemaforGo6) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo6, Point = 6, Image = Elements:GetElement(cx, cy, SemaforGo6)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end
            
            --if Cell.Connection[4] ~= nil and  - dx * k  < dy * k and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[4] == nil) ) then
            if AllowedPoint(Cell, 4) and - dx * k  < dy * k then
                if self:Hide(cx, cy, SemaforGo4) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo4, Point = 4, Image = Elements:GetElement(cx, cy, SemaforGo4)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end   
            
            if AllowedPoint(Cell, 8) and - dx * k  > dy * k then
            --if Cell.Connection[8] ~= nil and - dx * k  > dy * k and (Cell.Switch == nil or (Cell.Switch ~= nil and Cell.Switch[8] == nil) ) then
                if self:Hide(cx, cy, SemaforGo8) then
                    self.ShowObject = {x = cx, y = cy, Type = SemaforGo8, Point = 8, Image = Elements:GetElement(cx, cy, SemaforGo8)}
                    Layer:addChild(self.ShowObject.Image, SemaforesZIndex)
                    IsShow = true
                end
            end               
        end
    end   
    return IsShow;
end

function Semaphore:Set()
    local Object = self.ShowObject
    if Object.Image ~= nil then        
        local cmd = string.format('semaphore --add --x=%d --y=%d --point=%d', Object.x, Object.y, Object.Point)        
        Cmd:Exec(cmd)
        self:Hide()
        self.ShowObject = {}
    end
end

function Semaphore:Hide(x, y, Type)
    local Object = self.ShowObject   
    local hidden = Object.Image == nil
    if not hidden and x == nil then
        Resources:Instance():Get('rails_layer'):removeChild(Object.Image, true)
        hidden = true        
    end    
    
    if not hidden and Type ~= nil and (Object.x ~= x or Object.y ~= y or Object.Type ~= Type) then
        Resources:Instance():Get('rails_layer'):removeChild(Object.Image, true)
        hidden = true        
    end 
    
    if not hidden and x ~= nil and y ~= nil and Type == nil then
        local d = 1
        if math.abs(x - Object.x) > d or math.abs(y - Object.y) > d then 
            Resources:Instance():Get('rails_layer'):removeChild(Object.Image, true)
            hidden = true
        end
    end 
    
    return hidden
end

function Semaphore:Next()
    if self.Position == Go then
        self:SetPosition(Reverse)   
    elseif self.Position == Reverse then
        self:SetPosition(Stop)
    else
        self:SetPosition(Go)
    end
end

function Semaphore:SetPosition(Position)
    if Position == Go then
        self.Resources.Go:setVisible(true)
        self.Resources.Reverse:setVisible(false)
        self.Resources.Stop:setVisible(false)        
        self.Position = Go
    elseif Position == Reverse then
        self.Resources.Go:setVisible(false)
        self.Resources.Reverse:setVisible(true)
        self.Resources.Stop:setVisible(false)    
        self.Position = Reverse
    else
        self.Resources.Go:setVisible(false)
        self.Resources.Reverse:setVisible(false)
        self.Resources.Stop:setVisible(true)    
        self.Position = Stop
    end
    if #self.Trains > 0 then
        for c = 1, #self.Trains do            
            self.Trains[c]:SpeedProgramReset()          
        end
        self.Trains = {}
    end
end

function Semaphore:AddTrainListener(Train)
    local f = true
    if #self.Trains > 0 then         
        for c = 1, #self.Trains do
            if self.Trains[c]== Train then
                f = false
            end      
        end
    end
    if f then
        print("Semaphore:AddTrainListener")
        self.Trains[#self.Trains + 1] = Train
    end
end

function Semaphore:RemoveTrainListener(Train)    
    if #self.Trains > 0 then
        for c = 1, #self.Trains do
            if self.Trains[c]== Train then
                print("Semaphore:RemoveTrainListener")
                self.Trains[c] = nil
            end      
        end
    end    
end



