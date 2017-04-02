Switch = {}

function Switch:new(Cell, Point)

    local Elements = Elements:new()
    local Layer = Resources:Instance():Get('rails_layer')    
    local Element1, Element2, x, y

    Element1, x, y = Switch:GetElement(Cell.x, Cell.y, Cell.Connection[Point][1].Element, Cell.Connection[Point][1].Enter)
    local Image1 = Elements:GetElement(x, y, Element1)

    Image1.CellX=Cell.x
    Image1.CellY=Cell.y
    Image1.CellPoint=Point

    Image1:setVisible(true)
    Layer:addChild(Image1, SwitchesZIndex)

    Element2, x, y = Switch:GetElement(Cell.x, Cell.y, Cell.Connection[Point][2].Element, Cell.Connection[Point][2].Enter)    
    local Image2 = Elements:GetElement(x, y, Element2)
    Image2:setVisible(false)
    Layer:addChild(Image2, SwitchesZIndex)  

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

    local function onTouchEnded(touch, event)
        local target = event:getCurrentTarget()
        GameField:Instance().Cells[target.CellX][target.CellY].Switch[target.CellPoint]:SwitchPosition()
        print("switch onTouchesEnded..")
        target:setOpacity(255)        
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = Layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, Image1) 
    
    Object = {Position = 1, Cell = Cell, Point = Point, Elements = { {Resource = Image1, Element = Element1}, {Resource = Image2, Element = Element2}}, Trains = {}, Schedule = {}}
	self.__index = self	
    return setmetatable(Object, self) 
end

function Switch:GetElement(x, y, Element, Enter)
    local e
    
    --Horizontal
    if Element == Horizontal and Enter == 1 then
        e = SwitchHorizontal
    end
    
    if Element == Horizontal and Enter == 2 then
        e = SwitchHorizontal
        x = x - 1
    end
    
    --Vertical
    if Element == Vertical and Enter == 1 then
        e = SwitchVertical
    end

    if Element == Vertical and Enter == 2 then
        e = SwitchVertical
        y = y + 1
    end

    --SwitchItem45
    if Element == Item45 and Enter == 1 then
        e = SwitchItem45
    end

    if Element == Item45 and Enter == 2 then
        e = SwitchItem45
        y = y - 1
        x = x - 1
    end
    
    --SwitchItem45
    if Element == Item135 and Enter == 1 then
        e = SwitchItem135
    end

    if Element == Item135 and Enter == 2 then
        e = SwitchItem135
        y = y + 2
        x = x - 2
    end

    --SwitchItem45
    if Element == Item135 and Enter == 1 then
        e = SwitchItem135
    end
    
    if Element == Item135 and Enter == 2 then
        e = SwitchItem135
        y = y - 1
        x = x + 1
    end
    
    --BaseCircleSect0
    if Element == BaseCircleSect0 and Enter == 1 then
        e = SwitchBaseCircle01
    end
    
    if Element == BaseCircleSect0 and Enter == 2 then
        e = SwitchBaseCircle02        
    end
    
    --BaseCircleSect1
    if Element == BaseCircleSect1 and Enter == 1 then
        e = SwitchBaseCircle11
    end
    
    if Element == BaseCircleSect1 and Enter == 2 then
        e = SwitchBaseCircle12        
    end
    
    --BaseCircleSect2
    if Element == BaseCircleSect2 and Enter == 1 then
        e = SwitchBaseCircle21
    end
    
    if Element == BaseCircleSect2 and Enter == 2 then
        e = SwitchBaseCircle22        
    end
    
    --BaseCircleSect3
    if Element == BaseCircleSect3 and Enter == 1 then
        e = SwitchBaseCircle31
    end
    
    if Element == BaseCircleSect3 and Enter == 2 then
        e = SwitchBaseCircle32        
    end

    --BaseCircleSect4
    if Element == BaseCircleSect4 and Enter == 1 then
        e = SwitchBaseCircle41
    end

    if Element == BaseCircleSect4 and Enter == 2 then
        e = SwitchBaseCircle42        
    end
    
    --BaseCircleSect5
    if Element == BaseCircleSect5 and Enter == 1 then
        e = SwitchBaseCircle51
    end

    if Element == BaseCircleSect5 and Enter == 2 then
        e = SwitchBaseCircle52        
    end

    --BaseCircleSect6
    if Element == BaseCircleSect6 and Enter == 1 then
        e = SwitchBaseCircle61
    end
    
    if Element == BaseCircleSect6 and Enter == 2 then
        e = SwitchBaseCircle62        
    end
    
    --BaseCircleSect7
    if Element == BaseCircleSect7 and Enter == 1 then
        e = SwitchBaseCircle71
    end
    
    if Element == BaseCircleSect7 and Enter == 2 then
        e = SwitchBaseCircle72        
    end

    --SmallCilcleSect0
    if Element == SmallCilcleSect0 and Enter == 1 then
        e = SwitchSmallCilcle01
    end
    
    if Element == SmallCilcleSect0 and Enter == 2 then
        e = SwitchSmallCilcle02        
    end

    --SmallCilcleSect1
    if Element == SmallCilcleSect1 and Enter == 1 then
        e = SwitchSmallCilcle11
    end

    if Element == SmallCilcleSect1 and Enter == 2 then
        e = SwitchSmallCilcle12        
    end
    
    --SmallCilcleSect2
    if Element == SmallCilcleSect2 and Enter == 1 then
        e = SwitchSmallCilcle21
    end

    if Element == SmallCilcleSect2 and Enter == 2 then
        e = SwitchSmallCilcle22        
    end
    
    --SmallCilcleSect3
    if Element == SmallCilcleSect3 and Enter == 1 then
        e = SwitchSmallCilcle31
    end

    if Element == SmallCilcleSect3 and Enter == 2 then
        e = SwitchSmallCilcle32        
    end
    
    return e, x, y 
end

function Switch:SwitchPosition()

    --print('Switch:SwitchPosition');
    if self.Position == 1 then
        self.Elements[1].Resource:setVisible(false)
        self.Elements[2].Resource:setVisible(true)
        self.Position = 2
        self.Cell.Connection[self.Point].Position = 2
        self.Cell.Connection[self.Point].Track = 2
    else
        self.Elements[1].Resource:setVisible(true)
        self.Elements[2].Resource:setVisible(false)
        self.Position = 1
        self.Cell.Connection[self.Point].Position = 1
        self.Cell.Connection[self.Point].Track = 1
    end
    
    if #self.Trains > 0 then
        for c = 1, #self.Trains do
            self.Trains[c]:SpeedProgramReset()          
        end
        self.Trains = {}
    end
end

function Switch:AddTrainListener(Train)
    local f = true
    if #self.Trains > 0 then         
        for c = 1, #self.Trains do
            if self.Trains[c]== Train then
                f = false
            end      
        end
    end
    if f then
        --print("Switch:AddTrainListener")
        self.Trains[#self.Trains + 1] = Train
    end
end

function Switch:RemoveTrainListener(Train)    
    if #self.Trains > 0 then
        for c = 1, #self.Trains do
            if self.Trains[c]== Train then
                --print("Switch:RemoveTrainListener")
                self.Trains[c] = nil
            end      
        end
    end    
end