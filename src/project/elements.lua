Resources = {}
Resources.Items={}

function Resources:new()    
    Object = {}
    self.__index = self 
    return setmetatable(Object, self)
end

function Resources:setImage(key, image)    
    --self.Items[key] = CCTextureCache:sharedTextureCache():addImage(image)   
    self.Items[key] = cc.Director:getInstance():getTextureCache():addImage(image)   
end;

function Resources:setObject(key, object)    
    self.Items[key] = object   
end;

function Resources:Get(key)
    if self.Items[key]~=nil then
        return self.Items[key]
    end
end;

function Resources:Instance()
    return self
end

Elements={}

function Elements:new()	
    local Resource = Resources:Instance():Get('rails')    
	Object = {Resource = Resource}    
	self.__index = self	
	return setmetatable(Object, self)
end

function Elements:GetElement(x, y, Element)
	local Item 
	local d = 10 * GameField:Instance().Scale	
   
	if Element==Horizontal then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(d, 2.5 * d, d, d)))
		Item:setPosition(x * d + 0.5 * d , y * d)		
	end
	
	if Element==Vertical then       
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(d - 0.5 * d, d, d, d)))
		Item:setPosition(x * d, y * d - 0.5 * d)		
	end
	
	if Element==Item45 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(3 * d - 0.5 * d, d - 0.5 * d, 2 * d, 2 * d)))
		Item:setPosition(x * d + 0.5 *  d, y * d + 0.5 * d)		
	end
	
	if Element==Item135 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(3 * d - 0.5 * d ,3 * d - 0.5 * d, 2 * d, 2 * d)))
		Item:setPosition(x * d + 0.5 *  d, y * d - 0.5 * d)		
	end
	
	if Element==BaseCircleSect0 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(4.5 * d, 0.5 * d, 2 * d, 4 * d)))
		Item:setPosition(x * d - 0.5 * d, y * d + 1.5 * d)		
	end
	
	if Element==BaseCircleSect1 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(6.5 * d, 0.5 * d, 4 * d, 2 * d)))		
		Item:setPosition(x * d - 1.5 * d, y * d + 0.5 * d)		
	end
	
	if Element==BaseCircleSect2 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(6.5 * d, 2.5 * d, 4 * d, 2 * d)))
		Item:setPosition(x * d - 1.5 * d, y * d - 0.5 * d)		
	end
	
	if Element==BaseCircleSect3 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(10.5 * d, 0.5 * d, 2 * d, 4 * d)))
		Item:setPosition(x * d - 0.5 * d, y * d - 1.5 * d)		
	end
	
	if Element==BaseCircleSect4 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(12.5 * d, 0.5 * d, 2 * d, 4 * d)))
		Item:setPosition(x * d + 0.5 * d, y * d - 1.5 * d)		
	end
	
	if Element==BaseCircleSect5 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(14.5 * d, 0.5 * d, 4 * d, 2 * d)))
		Item:setPosition(x * d + 1.5 * d, y * d - 0.5 * d)		
	end
	
	if Element==BaseCircleSect6 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(14.5 * d, 2.5 * d, 4 * d, 2 * d)))
		Item:setPosition(x * d + 1.5 * d, y * d + 0.5 * d)		
	end
	
	if Element==BaseCircleSect7 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(18.5 * d, 0.5 * d, 2 * d, 4 * d)))
		Item:setPosition(x * d + 0.5 * d, y * d + 1.5 * d)		
	end
	
	if Element==SmallCilcleSect0 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(20.5 * d, 0.5 * d, 3 * d, 3 * d)))
		Item:setPosition(x * d -  d, y * d + d)		
	end
	
	if Element==SmallCilcleSect1 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(23.5 * d, 0.5 * d, 3 * d, 3 * d)))
		Item:setPosition(x * d -  d, y * d - d)		
	end
	
	if Element==SmallCilcleSect2 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(26.5 * d, 0.5 * d, 3 * d, 3 * d)))
		Item:setPosition(x * d +  d, y * d - d)		
	end
	
	if Element==SmallCilcleSect3 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(29.5 * d, 0.5 * d, 3 * d, 3 * d)))
		Item:setPosition(x * d +  d, y * d + d)		
	end
    
    --Switches        
    if Element==SwitchHorizontal then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(d, 6.5 * d, d, d)))
		Item:setPosition(x * d + 0.5 * d , y * d)		
	end    
 
	if Element==SwitchVertical then     
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(d - 0.5 * d, d + 4 * d, d, d)))
		Item:setPosition(x * d, y * d - 0.5 * d)		
	end
	
	if Element==SwitchItem45 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(3 * d - 0.5 * d, d + 3.5 * d, 2 * d, 2 * d)))
		Item:setPosition(x * d + 0.5 *  d, y * d + 0.5 * d)		
	end
	
	if Element==SwitchItem135 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(3 * d - 0.5 * d ,3 * d + 3.5 * d, 2 * d, 2 * d)))
		Item:setPosition(x * d + 0.5 *  d, y * d - 0.5 * d)		
	end
    
    -- base circle
    --0    
    if Element==SwitchBaseCircle01 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(4.5 * d, 6.5 * d, 2 * d, 2 * d)))
		Item:setPosition(x * d - 0.5 * d, y * d + 0.5 * d)		
	end
        
    if Element==SwitchBaseCircle02 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(4.5 * d, 4.5 * d, 2 * d, 2 * d)))
		Item:setPosition(x * d + 0.5 * d, y * d - 0.5 * d)		
	end

    -- 1
    if Element==SwitchBaseCircle11 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(8.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d + 0.5 * d)		
	end
    
    if Element==SwitchBaseCircle12 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(6.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d - 0.5 * d)		
	end
    
    -- 2
    if Element==SwitchBaseCircle21 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(8.5 * d, 6.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d - 0.5 * d)		
	end
    
    if Element==SwitchBaseCircle22 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(6.5 * d, 6.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d + 0.5 * d)		
	end
    
    -- 3    
    if Element==SwitchBaseCircle31 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(10.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d - 0.5 * d)		
	end
    
    if Element==SwitchBaseCircle32 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(10.5 * d, 6.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d + 0.5 * d)		
	end
    
    --4
    if Element==SwitchBaseCircle41 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(12.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d - 0.5 * d)		
	end
    
    if Element==SwitchBaseCircle42 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(12.5 * d, 6.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d + 0.5 * d)		
	end
    
    --5
    if Element==SwitchBaseCircle51 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(14.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d - 0.5 * d)		
	end
    
    if Element==SwitchBaseCircle52 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(16.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d + 0.5 * d)		
	end
    
    --6
    if Element==SwitchBaseCircle61 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(14.5 * d, 6.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d + 0.5 * d)		
	end
    
    if Element==SwitchBaseCircle62 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(16.5 * d, 6.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d - 0.5 * d)		
	end
    
    --7
    if Element==SwitchBaseCircle71 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(18.5 * d, 6.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d + 0.5 * d)		
	end
    
    if Element==SwitchBaseCircle72 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(18.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d - 0.5 * d)		
	end
    
    -- small circle
    --0
    if Element==SwitchSmallCilcle01 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(21.5 * d, 5.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d + 0.5 * d)		
	end
    
    if Element==SwitchSmallCilcle02 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(20.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d - 0.5 * d)		
	end
    
    --1
    if Element==SwitchSmallCilcle11 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(24.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d - 0.5 * d)		
	end
    
    if Element==SwitchSmallCilcle12 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(23.5 * d, 5.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d + 0.5 * d)		
	end
    
    --2
    if Element==SwitchSmallCilcle21 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(26.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d - 0.5 * d)		
	end
    
    if Element==SwitchSmallCilcle22 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(27.5 * d, 5.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d + 0.5 * d)		
	end
    
    --3
    if Element==SwitchSmallCilcle31 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(29.5 * d, 5.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d + 0.5 * d, y * d + 0.5 * d)		
	end
    
    if Element==SwitchSmallCilcle32 then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(30.5 * d, 4.5 * d, 2 * d, 2 * d)))		
		Item:setPosition(x * d - 0.5 * d, y * d - 0.5 * d)		
	end
    
    local k = 1
    if GameField:Instance().TrafficSide == LeftHandTraffic then
        k = -1
    end
    
    if Element==SemaforGo1 or Element==SemaforGo2 or Element==SemaforGo3 or Element==SemaforGo4 or Element==SemaforGo5 or Element==SemaforGo6 or Element==SemaforGo7 or Element==SemaforGo8 then
        Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(0.6 * d, 14.5 * d, 1 * d, 1 * d)))
    end    
    
    if Element==SemaforStop1 or Element==SemaforStop2 or Element==SemaforStop3 or Element==SemaforStop4 or Element==SemaforStop5 or Element==SemaforStop6 or Element==SemaforStop7 or Element==SemaforStop8 then
        Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(1.6 * d, 14.5 * d, 1 * d, 1 * d)))
    end 
    
    if Element==SemaforReverse1 or Element==SemaforReverse2 or Element==SemaforReverse3 or Element==SemaforReverse4 or Element==SemaforReverse5 or Element==SemaforReverse6 or Element==SemaforReverse7 or Element==SemaforReverse8 then
        Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(2.6 * d, 14.5 * d, 1 * d, 1 * d)))
    end 
    
    if Element==SemaforGo1 or Element==SemaforStop1 or Element==SemaforReverse1 then				
		Item:setPosition(x * d, y * d + k * 0.5 * d)		
	end
    
    if Element==SemaforGo2 or Element==SemaforStop2 or Element==SemaforReverse2 then		      
        Item:setPosition(x * d - k * 0.3525 * d, y * d + k * 0.3525 * d)     
        Item:setRotation(315)        
	end
    
    if Element==SemaforGo3 or Element==SemaforStop3 or Element==SemaforReverse3 then		      
        Item:setPosition(x * d - k * 0.5 * d, y * d)             
        Item:setRotation(270)        
	end
    
    if Element==SemaforGo4 or Element==SemaforStop4 or Element==SemaforReverse4 then		      
        Item:setPosition(x * d - k * 0.3525 * d, y * d - k * 0.3525 * d)             
        Item:setRotation(225)        
	end
    
    if Element==SemaforGo5 or Element==SemaforStop5 or Element==SemaforReverse5 then		      
        Item:setPosition(x * d, y * d - k * 0.5 * d)             
        Item:setRotation(180)        
	end
    
    if Element==SemaforGo6 or Element==SemaforStop6 or Element==SemaforReverse6 then		      
        Item:setPosition(x * d + k * 0.3525 * d, y * d - k * 0.3525 * d)  
        Item:setRotation(135)        
	end
    
    if Element==SemaforGo7 or Element==SemaforStop7 or Element==SemaforReverse7 then		      
        Item:setPosition(x * d + k * 0.5 * d, y * d) 
        Item:setRotation(90)        
	end
       
    if Element==SemaforGo8 or Element==SemaforStop8 or Element==SemaforReverse8 then		      
        Item:setPosition(x * d + k * 0.3525 * d, y * d + k * 0.3525 * d)        
        Item:setRotation(45)        
	end
       
	return Item
end

function Elements:GetCarElement(Element)
    local d = 10 * GameField:Instance().Scale
    
    if Element==Locomotive then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(0.5 * d, 8.5 * d, 3 * d, 1 * d)))
	end
    
    if Element==TankCar then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(3.5 * d, 8.5 * d, 3 * d, 1 * d)))
	end
    
    if Element==Switcher then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(6.8 * d, 8.5 * d, 2 * d, 1 * d)))
	end
    
    return Item
end

function Elements:GetMenuElement(Element)
    local d = 10 * GameField:Instance().Scale
    
    --StartButton
    if Element==StartButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==StartButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(d, 12 * d, 2 * d, 2 * d)))
	end
    
    --FastButton
    if Element==FastButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(3 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==FastButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(3 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    --PauseButton
    if Element==PauseButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(5 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==PauseButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(5 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    --StopButton
    if Element==StopButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(7 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==StopButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(7 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    --RailsButton
    if Element==RailsButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(9 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==RailsButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(9 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    if Element==RailsButtonCheckedEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(23 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==RailsButtonCheckedDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(23 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    --SemaforesButton
    if Element==SemaforesButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(11 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==SemaforesButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(11 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    if Element==SemaforesButtonCheckedEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(25 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==SemaforesButtonCheckedDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(25 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    --ZoomInButton
    if Element==ZoomInButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(13 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==ZoomInButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(13 * d, 12 * d, 2 * d, 2 * d)))
	end
        
    --ZoomOutButton
    if Element==ZoomOutButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(15 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==ZoomOutButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(15 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    --UndoButton
    if Element==UndoButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(17 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==UndoButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(17 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    --RedoButton
    if Element==RedoButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(19 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==RedoButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(19 * d, 12 * d, 2 * d, 2 * d)))
	end
   
    --TasksButton
    if Element==TasksButtonEnabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(21 * d, 10 * d, 2 * d, 2 * d)))
	end
    
    if Element==TasksButtonDisabled then
		Item = CCSprite:createWithSpriteFrame(CCSpriteFrame:createWithTexture(self.Resource, cc.rect(21 * d, 12 * d, 2 * d, 2 * d)))
	end
    
    return Item
end