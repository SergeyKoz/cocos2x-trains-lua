Car = {}
Car.Axis1 = {}
Car.Axis2 = {}

function Car:new(Object)
    local CarImage = Elements:new():GetCarElement(Object.Type)    
    Resources:Instance():Get('rails_layer'):addChild(CarImage, TrainsZIndex)
    Object.Resource = CarImage
    self.__index = self	
	return setmetatable(Object, self) 
end

function Car:SetPosition(Position)
    local Pos = Position
    local x1, y1 = Path:GetPositionCoordinates(Pos)
    self.Axis1 = {Position = Pos}        
    Pos = Path:GetPosition(Pos, -self.Type.base)    
    local x2, y2 = Path:GetPositionCoordinates(Pos)        
    self.Axis2 = {Position = Pos}   
    local Move = {dx = (x1 + (x2 - x1) / 2) * 2, dy = (y1 + (y2 - y1) / 2) * 2, a = math.deg(math.atan2((x2 - x1), (y2 - y1)) + math.pi / 2)}
    self.Resource:setPosition(Move.dx, Move.dy)	
    self.Resource:setRotation(Move.a)
    return Path:GetPosition(Pos, -4)   
end

function Car:RunMove()
    self.Resource:runAction(CCMoveTo:create(0.2, self.Move.p))
    self.Resource:runAction(CCRotateTo:create(0.2, self.Move.a))
    
    --self.Resource:setPosition(self.Move.p)   
    --self.Resource:setRotation(self.Move.a)
end

function Car:GetMove(Move, Estimate)    
    local Pos
    
    Pos = Path:GetPosition(self.Axis1.Position, Move, Estimate)    
    local x1, y1 = Path:GetPositionCoordinates(Pos)   
    self.Axis1.Position = Pos
    Pos = Path:GetPosition(self.Axis2.Position, Move, Estimate)
    local x2, y2 = Path:GetPositionCoordinates(Pos)
    self.Axis2.Position = Pos  
    
    self.Move = {}
    self.Move.p = cc.p((x1 + (x2 - x1) / 2) * 2, (y1 + (y2 - y1) / 2) * 2)
    self.Move.a = math.deg(math.atan2((x2 - x1), (y2 - y1)) + math.pi / 2)    
end
