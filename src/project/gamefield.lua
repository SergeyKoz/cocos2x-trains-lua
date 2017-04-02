GameField = {}

GameField.FieldSizeX = 1000
GameField.FieldSizeY = 500
GameField.Scale = 2
GameField.TrafficSide = RightHandTraffic
--GameField.TrafficSide = LeftHandTraffic
GameField.Cells = {}
GameField.Trains = {}

GameField.Mode = Construction
GameField.ConstructionMode = ConstructionRails

function GameField:new()
    Object = {}
	for x = 1, self.FieldSizeX do
		self.Cells[x] = {}
        for y = 1, self.FieldSizeY do			
			self.Cells[x][y] = Cell:new(x, y)
		end
	end
	
	self.__index = self
	return setmetatable(Object, self)
end;

function GameField:Instance()
	return self
end

function GameField:getCell(x, y)
	if x > 0 and y > 0 then 
        return self.Cells[x][y]
	end
end;

function GameField:AddTrain(Train)    
    table.insert(self.Trains, Train)
end

Cell = {}

Cell.configuration = None

function Cell:new(x, y)
	Object = {x = x, y = y}	
	self.__index = self
	return setmetatable(Object, self)
end; 

function Cell:setConfiguration(state)
	self.configuration = state
end;

function Cell:getConfiguration()
	return self.configuration;
end

function Cell:Connect(cell, Point, second)	-- from point
    local dx=cell.x-self.x
	local dy=cell.y-self.y
	
    local connect = Cell:GetConnectConfig(dx, dy, Point)	
	self:SetEntry(cell, Point, connect.point, connect.config, connect.element, connect.enter)
	
	if not second then
		cell:Connect(self, connect.point, true);
	end	
end

function Cell:SetSwitch(Point)
    if self.Switch == nil then
        self.Switch={}
    end
    self.Switch[Point] = Switch:new(self, Point)
end

function Cell:SetSemaphore(Point)
    if self.Semaphore == nil then
		self.Semaphore={}
	end    
    self.Semaphore[Point] = Semaphore:new(self, Point)
end

function Cell:GetConnectConfig(dx, dy, Point) -- from point
	local connect
	
	-- horizontal
	if dx == 1 and dy == 0 then
		connect = {config = Ortogonal, element = Horizontal, point = self:Related(Point), enter = 2}
	end
	
	if dx == -1 and dy == 0 then
		connect = {config = Ortogonal, element = Horizontal, point = self:Related(Point), enter = 1}
	end
	
	--Vertical
	if dx == 0 and dy == -1 then
		connect = {config = Ortogonal, element = Vertical, point = self:Related(Point), enter = 2}
	end
	
	if dx == 0 and dy == 1 then
		connect = {config = Ortogonal, element = Vertical, point = self:Related(Point), enter = 1}
	end
	
	--Item45
	if dx == 1 and dy == 1 then
		connect = {config = Polar, element = Item45, point = self:Related(Point), enter = 2}
	end
	
	if dx == -1 and dy == -1 then
		connect = {config = Polar, element = Item45, point = self:Related(Point), enter = 1}
	end
	
	--Item135
	if dx == 1 and dy == -1 then
		connect = {config = Polar, element = Item135, point = self:Related(Point), enter = 2}
	end
	
	if dx == -1 and dy == 1 then
		connect = {config = Polar, element = Item135, point = self:Related(Point), enter = 1}
	end
	
	--BaseCircleSect0	
	if dy == 3 and dx == -1 and Point == 3 then
		connect = {config = Polar, element = BaseCircleSect0, point = 8, enter = 2}
	end
	
	if dy == -3 and dx == 1 and Point == 8 then
		connect = {config = Ortogonal, element = BaseCircleSect0, point = 3, enter = 1}
	end
	
	--BaseCircleSect1	
	if dy == 1 and dx == -3 and Point == 4 then
		connect = {config = Ortogonal, element = BaseCircleSect1, point = 1, enter = 2}
	end
	
	if dy == -1 and dx == 3 and Point == 1 then
		connect = {config = Polar, element = BaseCircleSect1, point = 4, enter = 1}
	end
	
	--BaseCircleSect2	
	if dy == -1 and dx == -3 and Point == 5 then
		connect = {config = Polar, element = BaseCircleSect2, point = 2, enter = 2}
	end
	
	if dy == 1 and dx == 3 and Point == 2 then		
		connect = {config = Ortogonal, element = BaseCircleSect2, point = 5, enter = 1}
	end
	
	--BaseCircleSect3	
	if dy == -3 and dx == -1 and Point == 6 then
		connect = {config = Ortogonal, element = BaseCircleSect3, point = 3, enter = 2}
	end
	
	if dy == 3 and dx == 1 and Point == 3 then
		connect = {config = Polar, element = BaseCircleSect3, point = 6, enter = 1}
	end
	
	--BaseCircleSect4
	if dy == -3 and dx == 1 and Point == 7 then		
		connect = {config = Polar, element = BaseCircleSect4, point = 4, enter = 2}
	end
	
	if dy == 3 and dx == -1 and Point == 4 then		
		connect = {config = Ortogonal, element = BaseCircleSect4, point = 7, enter = 1}
	end	
	
	--BaseCircleSect5
	if dy == -1 and dx == 3 and Point == 8 then		
		connect = {config = Ortogonal, element = BaseCircleSect5, point = 5, enter = 2}
	end
	
	if dy == 1 and dx == -3 and Point == 5 then		
		connect = {config = Polar, element = BaseCircleSect5, point = 8, enter = 1}
	end	
	
	--BaseCircleSect6
	if dy == 1 and dx == 3 and Point == 1 then		
		connect = {config = Polar, element = BaseCircleSect6, point = 6, enter = 2}
	end
	
	if dy == -1 and dx == -3 and Point == 6 then		
		connect = {config = Ortogonal, element = BaseCircleSect6, point = 1, enter = 1}
	end	
	
	--BaseCircleSect7
	if dy == 3 and dx == 1 and Point == 2 then		
		connect = {config = Ortogonal, element = BaseCircleSect7, point = 7, enter = 2}
	end
	
	if dy == -3 and dx == -1 and Point == 7 then		
		connect = {config = Polar, element = BaseCircleSect7, point = 2, enter = 1}
	end
	
	--SmallCilcleSect0
	if dy == 2 and dx == -2 and Point == 3 then		
		connect = {config = Ortogonal, element = SmallCilcleSect0, point = 1, enter = 2}
	end
	
	if dy == -2 and dx == 2 and Point == 1 then		
		connect = {config = Ortogonal, element = SmallCilcleSect0, point = 3, enter = 1}
	end	
	
	--SmallCilcleSect1
	if dy == -2 and dx == -2 and Point == 5 then		
		connect = {config = Ortogonal, element = SmallCilcleSect1, point = 3, enter = 2}
	end
	
	if dy == 2 and dx == 2 and Point == 3 then		
		connect = {config = Ortogonal, element = SmallCilcleSect1, point = 5, enter = 1}
	end	
	
	--SmallCilcleSect2
	if dy == -2 and dx == 2 and Point == 7 then		
		connect = {config = Ortogonal, element = SmallCilcleSect2, point = 5, enter = 2}
	end
	
	if dy == 2 and dx == -2 and Point == 5 then		
		connect = {config = Ortogonal, element = SmallCilcleSect2, point = 7, enter = 1}
	end	
	
	--SmallCilcleSect3
	if dy == 2 and dx == 2 and Point == 1 then	
		connect = {config = Ortogonal, element = SmallCilcleSect3, point = 7, enter = 2}
	end
	
	if dy == -2 and dx == -2 and Point == 7 then		
		connect = {config = Ortogonal, element = SmallCilcleSect3, point = 1, enter = 1}
	end
	
	return connect
end

function Cell:SetEntry(cell, FromPoint, ToPoint, Configuration, Element, Enter)
   
	local entry = Entry:new(cell, self, FromPoint, Element, Enter)
	cell:setConfiguration(Configuration)
	
	if cell.Connection == nil then
		cell.Connection={}
	end
	
	if cell.Connection[ToPoint] == nil then
		cell.Connection[ToPoint] = {Position = 1, Element = Element}
	end
	
	if cell.Connection[ToPoint][1] == nil then
		cell.Connection[ToPoint][1]=entry
	else
		cell.Connection[ToPoint][2]=entry
	end	
end

function Cell:GetEntry(Point)
	local Entry
	if self.Connection ~= nil and self.Connection[Point] ~= nil then
		Entry=self.Connection[Point]
	end
	return Entry;
end

function Cell:IsConnected(Point, Enter)
	local f = false
	local E = 1
	if Enter == nil then
		E = Enter
	end
	if self.Connection[Point][E] ~= nil then
		f=true
	end
	return f
end

function Cell:Related(In)
	local Out
	if In==1 then Out=5 end
	if In==2 then Out=6 end
	if In==3 then Out=7 end
	if In==4 then Out=8 end
	if In==5 then Out=1 end
	if In==6 then Out=2 end
	if In==7 then Out=3 end
	if In==8 then Out=4 end
	return Out
end
--[[
function Cell:GetConnection(Point)
    if self.Connection[Point] ~= nil then
        local Position = 1        
        if self.Switch ~=nil and self.Switch[Point] ~=nil and self.Switch[Point].Position == 2 then
            Position = 2
        end        
        return self.Connection[Point][Position]
    end
end
]]--

Entry = {}

function Entry:new(from, to, Point, Element, Enter)
    local Image    
    if Enter==1 then
        local Elements = Elements:new()
        local Layer = Resources:Instance():Get('rails_layer')
        Image = Elements:GetElement(from.x, from.y, Element)        
        Layer:addChild(Image, RailsZIndex)
    end
    Object = {Cell = to, Element = Element, Point = Point, Enter = Enter, Resource = Image}    
	self.__index = self	
	return setmetatable(Object, self)
end;

function Entry:getEnter()
	return self.Enter;
end;