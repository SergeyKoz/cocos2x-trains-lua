Path={}

Path.Field = {}
Path.Items = {}
Path.Area = {AreaWidth = 4}

function Path:new() 
	Object = {}
	self.__index = self
	return setmetatable(Object, self)
end;

function Path:InitPath(x, y)
	local p1, p2
    local Area = self.Area
	local Game=GameField:Instance()
	local StartCell = Game:getCell(x, y)
    local Points, Related
	if StartCell.configuration==Polar or StartCell.configuration==Ortogonal then
		
        for c = 1, 8 do
			if StartCell.Connection[c] == nil and StartCell.Connection[Cell:Related(c)] ~= nil then
				p1 = c
			end
		end
        
        if p1 == nil then
            if StartCell.configuration==Ortogonal then
                Points ={1, 3, 5, 7}
                for i = 1, #Points do                
                    if p1 == nil then
                        Related = Cell:Related(Points[i])
                        if StartCell.Connection[Points[i]] ~= nil and StartCell.Connection[Points[i]][1] ~= nil and StartCell.Connection[Points[i]][2] == nil then
                            p1 = Points[i]
                        end
                        if p1 ~= nil and StartCell.Connection[Related] ~= nil and StartCell.Connection[Related][1] ~= nil and StartCell.Connection[Related][2] == nil then
                            p2 = Related
                        end                    
                    end                
                end            
            end

            if StartCell.configuration==Polar then
                Points ={2, 4, 6, 8}
                for i = 1, #Points do                
                    if p1 == nil then
                        Related = Cell:Related(Points[i])
                        if StartCell.Connection[Points[i]] ~= nil and StartCell.Connection[Points[i]][1] ~= nil and StartCell.Connection[Points[i]][2] == nil then
                            p1 = Points[i]
                        end
                        if p1 ~= nil and StartCell.Connection[Related] ~= nil and StartCell.Connection[Related][1] ~= nil and StartCell.Connection[Related][2] == nil then
                            p2 = Related
                        end                    
                    end                
                end            
            end
        end
    end	

    if p1 ~= nil then		
        self.Field = {}
        self.Items = {}
        Area.sx = x
		Area.sy = y        
        Area.sc = StartCell
        
        local Field = self.Field
        if Field[x] == nil then
            Field[x]= {}		
            Field[x][y] = GraphPoint:new(x, y)
            for c = 1, 8 do
                if c == p1 then
                    Field[x][y].D[c]=1
                elseif c == p2 then
                    Field[x][y].D[c]=2
                else
                    Field[x][y].D[c]=0
                end
            end		
        end
        
	end
	return p1 
end

function Path:FindPath(Cell, Point)    
	
    local Game=GameField:Instance()
    local Field = self.Field
    
    if Point ~= nil then
    
        local x = Cell.x
        local y = Cell.y
	
        D = Field[x][y].D[Point]
	
        if Point == 1 then
            self:SetConnection(Cell, 1, Game:getCell(x + 2, y + 2), 7, SmallCilcleSect3, D + 314, 1)
            self:SetConnection(Cell, 1, Game:getCell(x + 3, y + 1), 6, BaseCircleSect6, D + 321, 1)
            self:SetConnection(Cell, 1, Game:getCell(x + 1, y), 5, Horizontal, D + 100, 1)
            self:SetConnection(Cell, 1, Game:getCell(x + 3, y - 1), 4, BaseCircleSect1, D + 321, 2)
            self:SetConnection(Cell, 1, Game:getCell(x + 2, y - 2), 3, SmallCilcleSect0, D + 314, 2)
        end 
        
        if Point == 3 then
            self:SetConnection(Cell, 3, Game:getCell(x - 2, y + 2), 1, SmallCilcleSect0, D + 314, 1)		
            self:SetConnection(Cell, 3, Game:getCell(x - 1, y + 3), 8, BaseCircleSect0, D + 321, 1)
            self:SetConnection(Cell, 3, Game:getCell(x, y + 1), 7, Vertical, D + 100, 2)
            self:SetConnection(Cell, 3, Game:getCell(x + 1, y + 3), 6, BaseCircleSect3, D + 321, 2)
            self:SetConnection(Cell, 3, Game:getCell(x + 2, y + 2), 5, SmallCilcleSect1, D + 314, 2)
        end
        
        if Point == 5 then
            self:SetConnection(Cell, 5, Game:getCell(x - 2, y + 2), 7, SmallCilcleSect2, D + 314, 2)		
            self:SetConnection(Cell, 5, Game:getCell(x - 3, y + 1), 8, BaseCircleSect5, D + 321, 2)
            self:SetConnection(Cell, 5, Game:getCell(x - 1, y), 1, Horizontal, D + 100, 2)
            self:SetConnection(Cell, 5, Game:getCell(x - 3, y - 1), 2, BaseCircleSect2, D + 321, 1)
            self:SetConnection(Cell, 5, Game:getCell(x - 2, y - 2), 3, SmallCilcleSect1, D + 314, 1)
        end 
        
        if Point == 7 then
            self:SetConnection(Cell, 7, Game:getCell(x - 2, y - 2), 1, SmallCilcleSect3, D + 314, 2)		
            self:SetConnection(Cell, 7, Game:getCell(x - 1, y - 3), 2, BaseCircleSect7, D + 321, 2)
            self:SetConnection(Cell, 7, Game:getCell(x, y - 1), 3, Vertical, D + 100, 1)		
            self:SetConnection(Cell, 7, Game:getCell(x + 1, y - 3), 4, BaseCircleSect4, D + 321, 1)
            self:SetConnection(Cell, 7, Game:getCell(x + 2, y - 2), 5, SmallCilcleSect2, D + 314, 1)
        end

        if Point == 2 then				
            self:SetConnection(Cell, 2, Game:getCell(x + 1, y + 3), 7, BaseCircleSect7, D + 321, 1)
            self:SetConnection(Cell, 2, Game:getCell(x + 1, y + 1), 6, Item45, D + 141, 1)		
            self:SetConnection(Cell, 2, Game:getCell(x + 3, y + 1), 5, BaseCircleSect2, D + 321, 2)		
        end

        if Point == 4 then
            self:SetConnection(Cell, 4, Game:getCell(x - 1, y + 3), 7, BaseCircleSect4, D + 321, 2)
            self:SetConnection(Cell, 4, Game:getCell(x - 1, y + 1), 8, Item135, D + 141, 2)
            self:SetConnection(Cell, 4, Game:getCell(x - 3, y + 1), 1, BaseCircleSect1, D + 321, 1)
        end
        
        if Point == 6 then
            self:SetConnection(Cell, 6, Game:getCell(x - 1, y - 3), 3, BaseCircleSect3, D + 321, 1)
            self:SetConnection(Cell, 6, Game:getCell(x - 1, y - 1), 2, Item45, D + 141, 2)
            self:SetConnection(Cell, 6, Game:getCell(x - 3, y - 1), 1, BaseCircleSect6, D + 321, 2)
        end
        
        if Point == 8 then
            self:SetConnection(Cell, 8, Game:getCell(x + 1, y - 3), 3, BaseCircleSect0, D + 321, 2)		
            self:SetConnection(Cell, 8, Game:getCell(x + 1, y - 1), 4, Item135, D + 141, 1)
            self:SetConnection(Cell, 8, Game:getCell(x + 3, y - 1), 5, BaseCircleSect5, D + 321, 1)
        end	
    end
    
	local Min
	local NextX, NextY
	local NextEnter, Enter
    local InArea
	
	if Field ~= nil then
		for X, itemX in pairs(Field) do				
			for Y, Item in pairs(itemX) do
                InArea = false
                if Item.InArea then
                    InArea = true
                else
                    if Path:InArea(X, Y) then
                        InArea = true
                    end
                end

                if InArea then                   
                    for C = 1, 8 do				
                        if Item.F[C] == nil and Item.D[C] ~= nil and Item.D[C] > 0 and (Min == nil or Item.D[C] < Min) then
                            Min=Item.D[C]
                            NextX = X
                            NextY = Y
                            Enter = C                           
                        end
                    end
                end
			end
		end
	end
  
	local Out	
    if Min ~= nil then
       
        Field[NextX][NextY].F[Enter] = 1
		
        if Field[NextX][NextY].In[Enter] ~= nil then

            NextEnter = Cell:Related(Enter)
		
            Out = Field[NextX][NextY].In[Enter]		
            Field[Out.x][Out.y].F[Enter] = 1    

            Field[NextX][NextY].F[NextEnter] = 1		
            Field[NextX][NextY].D[NextEnter] = Min + 1
            
            self:FindPath(Game:getCell(NextX, NextY), NextEnter) 
        else
            self:FindPath(Game:getCell(NextX, NextY), Enter)
        end 
	end		

end;

function Path:SetConnection(Out, OutPoint, In, InPoint, Element, D, Enter)
	if In ~= nil then     
        local InX = In.x
		local InY = In.y
        
        local OutX = Out.x
        local OutY = Out.y
        
        local Field = self.Field 
        
        --check ortogonal enter
        local BaseOrtoCircle = false		
        if (OutPoint==2 or OutPoint==4 or OutPoint==6 or OutPoint==8) and (Element==BaseCircleSect0 or Element==BaseCircleSect1 or Element==BaseCircleSect2 or Element==BaseCircleSect3 or Element==BaseCircleSect4 or Element==BaseCircleSect5 or Element==BaseCircleSect6 or Element==BaseCircleSect7) then
            local OutRelatedPoint = Cell:Related(OutPoint)			
            if (OutRelatedPoint==2 or OutRelatedPoint==6) and Path:IsAllowedIn(Out, OutRelatedPoint, Item45)==false then
                BaseOrtoCircle = true
            end			
            if (OutRelatedPoint==4 or OutRelatedPoint==8) and Path:IsAllowedIn(Out, OutRelatedPoint, Item135)==false then
                BaseOrtoCircle = true
            end			
            if BaseOrtoCircle == false and Field[OutX][OutY].Out[OutRelatedPoint]==OutPoint then
                BaseOrtoCircle = true
            end
        else
            BaseOrtoCircle = true
        end
        
        if Path:IsAllowedIn(In, InPoint, Element) and BaseOrtoCircle then		
            if Field[InX] == nil then
                Field[InX]= {}
            end
            
            if Field[InX][InY] == nil then			
                Field[InX][InY] = GraphPoint:new(InX, InY)
            end
            
            local O = Field[OutX][OutY]
            local I = Field[InX][InY]
            
            if I.D[InPoint] == nil then
                I.D[InPoint]=D
                I.In[InPoint]=Out
                I.Out[InPoint]=OutPoint	
            elseif I.D[InPoint] > D then 
                I.D[InPoint]=D
                I.In[InPoint]=Out
                I.Out[InPoint]=OutPoint
            end	

            if not O.InArea then
                O.InArea=Path:InArea(OutX, OutY)
            end
        end       
	end	
end

function Path:IsAllowedIn(Cell, Point, Element)
	IsAllowed = true
    
    if Cell.configuration ~=nil then
        if Cell.configuration == Ortogonal then
            if Point == 2 or Point == 4 or Point == 6 or Point == 8 then
                IsAllowed = false
            end

            if IsAllowed then
                if (Cell.Connection[1]~=nil or Cell.Connection[5]~=nil) and (Point == 3 or Point == 7) then
                    IsAllowed = false
                end
                
                if (Cell.Connection[3]~=nil or Cell.Connection[7]~=nil) and (Point == 1 or Point == 5) then
                    IsAllowed = false
                end
            end            
        end
        
        if Cell.configuration == Polar then
            if Point == 1 or Point == 3 or Point == 5 or Point == 7 then
                IsAllowed = false
            end
            
            if IsAllowed then
                if (Cell.Connection[2]~=nil or Cell.Connection[6]~=nil) and (Point == 4 or Point == 8) then
                    IsAllowed = false
                end
                
                 if (Cell.Connection[4]~=nil or Cell.Connection[8]~=nil) and (Point == 2 or Point == 6) then
                    IsAllowed = false
                end
            end
        end       
    end
    
	if IsAllowed and Cell.Connection~=nil and Cell.Connection[Point]~=nil then
		if (Cell.Connection[Point][1]~=nil and Cell.Connection[Point][1].Element==Element ) or (Cell.Connection[Point][2]~=nil and Cell.Connection[Point][2].Element==Element)  then
			IsAllowed = false
		end
	end	
    
	return IsAllowed
end

function Path:InArea(x, y)

    local f = false    
    local a = self.Area  
    local w = a.AreaWidth    
    local rx, ry, lx, ly
    
    if a.dx == 0 and x > a.sx - w and x < a.sx + w then
        if a.dy > 0  and y > a.sy - w and y < a.ey + w then
            f = true
        end
        
        if a.dy < 0 and y > a.ey - w and y < a.sy + w then
            f = true
        end
    end
  
    if a.dy == 0 and y > a.sy - w and y < a.sy + w then
        if a.dx > 0  and x > a.sx - w and x < a.ex + w then
            f = true
        end
        
        if a.dx < 0 and x > a.ex - w and x < a.sx + w then
            f = true
        end
    end
  
    if a.tg ~= nil then
        if a.tg > 0 then            
            if a.dx >= 0 then
               rx = a.ex + w * a.cos
               ry = a.ey + w * a.sin           
               lx = a.sx - w * a.cos
               ly = a.sy - w * a.sin
            else
               rx = a.sx + w * a.cos
               ry = a.sy + w * a.sin               
               lx = a.ex - w * a.cos
               ly = a.ey - w * a.sin              
            end
            
            if  x - a.sx > a.tg * (y - a.sy - w) and x - a.sx < a.tg * (y - a.sy + w) and x - lx > - a.ctg * (y - ly) and x - rx < - a.ctg * (y - ry) then              
                f = true
            end
        end

        if a.tg < 0 then        
            if  a.dx >= 0 then
                rx = a.ex + w * a.cos
                ry = a.ey - w * a.sin           
                lx = a.sx - w * a.cos
                ly = a.sy + w * a.sin
            else
                rx = a.sx + w * a.cos
                ry = a.sy - w * a.sin
                lx = a.ex - w * a.cos
                ly = a.ey + w * a.sin
            end
           
            if x - a.sx < a.tg * (y - a.sy - w) and x - a.sx > a.tg * (y - a.sy + w) and x - rx < - a.ctg * (y - ry) and x - lx >  - a.ctg * (y - ly) then                   
                f = true
            end             
        end 
        
    end
    
    return f
end

function Path:Show(x, y)

	local Game=GameField:Instance()
	local Elements=Elements:new()
    local Layer=Resources:Instance():Get('rails_layer')
	
    local Min, Point, CurrentCell, NextCell, CurrentPoint, NextPoint

	local Field = self.Field
    
    local a = self.Area
    
    local changed = false
    
    if a.ex == nil then
        changed = true
    else
        if not (a.ex==x and a.ey==y) then
            changed = true
        end
    end
    
    if changed then
        a.dx = x - a.sx
        a.dy = y - a.sy
        
        a.ex = x
        a.ey = y 
        
        if a.dx ~= 0 and a.dy ~= 0 then       
            a.tg = a.dx / a.dy            
            a.ctg = 1 / a.tg    
            a.sin = math.sqrt (1 / (1 +  a.tg ^ 2) )
            a.cos = math.sqrt (1 / (1 +  a.ctg ^ 2) )
        end
        
        a.r = math.floor((math.sqrt (math.abs(a.dx) ^ 2 + math.abs(a.dy) ^ 2) * 2) * 100)

        Path:FindPath(a.sc)       
        
        -- get path	
        CurrentCell = Game:getCell(x, y)
        
        if Field[x] ~= nil and Field[x][y] ~= nil then
            for c = 1, 8 do
                if Field[x][y].Out[c] ~= nil then
                    if (Min == nil or Field[x][y].D[c]<Min) and Field[x][y].D[c] < a.r then 
                        Min=Field[x][y].D[c]
                        Point=c
                    end
                end
            end
        
            local connect
            local RailItem
                
            for c = 1, #self.Items do
                Layer:removeChild(self.Items[c].element, true)
            end
            
            self.Items={}    
            if Point~=nil and (a.dx ~= 0 or a.dy ~= 0) then   
                local i=1
                local dx, dy	
                while Field[CurrentCell.x][CurrentCell.y].D[Point]>0 and Field[CurrentCell.x][CurrentCell.y].In[Point] ~=nil do		
                    NextCell=Field[CurrentCell.x][CurrentCell.y].In[Point]
                    NextPoint=Cell:Related(Field[CurrentCell.x][CurrentCell.y].Out[Point])
                    
                    dx=NextCell.x-CurrentCell.x
                    dy=NextCell.y-CurrentCell.y		
                    connect = Cell:GetConnectConfig(dx, dy, Point)
                    if connect.enter==2 then
                        self.Items[i]={element = Elements:GetElement(CurrentCell.x, CurrentCell.y, connect.element)}
                    else
                        self.Items[i]={element = Elements:GetElement(NextCell.x, NextCell.y, connect.element)}
                    end
                    
                    self.Items[i].next = NextCell
                    self.Items[i].current = CurrentCell
                    self.Items[i].point = Point
                    
                    CurrentCell=NextCell
                    Point=NextPoint	
                    i =	i + 1 	
                end	

                for c = 1, #self.Items do		
                    Layer:addChild(self.Items[c].element)
                end
            end
        
        end
    end
end

function Path:Set()
    local Layer=Resources:Instance():Get('rails_layer')
    local cmd   
    local FromPoint, ToPoint
    local dx, dy, connect
    local path = {}
    local switch = {}
    local i = 1
	for c = 1, #self.Items do 
        FromPoint = self.Items[c].point    
        path[c]=string.format('{\'from\':{\'x\':%d,\'y\':%d},\'to\':{\'x\':%d,\'y\':%d},\'point\':%d}', self.Items[c].current.x, self.Items[c].current.y, self.Items[c].next.x, self.Items[c].next.y, FromPoint)
        
        dx=self.Items[c].next.x-self.Items[c].current.x
        dy=self.Items[c].next.y-self.Items[c].current.y
        
        connect = Cell:GetConnectConfig(dx, dy, FromPoint)
        ToPoint = connect.point
        
        if (self.Items[c].current.Connection and self.Items[c].current.Connection[FromPoint]~=nil and self.Items[c].current.Connection[FromPoint][1]~=nil) then
            switch[i]=string.format('{\'cell\':{\'x\':%d,\'y\':%d},\'point\':%d}', self.Items[c].current.x, self.Items[c].current.y, FromPoint)
            i = i + 1
        end
        
        if (self.Items[c].next.Connection and self.Items[c].next.Connection[ToPoint]~=nil and self.Items[c].next.Connection[ToPoint][1]~=nil) then
            switch[i]=string.format('{\'cell\':{\'x\':%d,\'y\':%d},\'point\':%d}', self.Items[c].next.x, self.Items[c].next.y, ToPoint)
            i = i + 1
        end
        
        Layer:removeChild(self.Items[c].element, true)
	end
    
    switch=table.concat(switch, ",")
    if switch ~= '' then
        switch = '--switch=['..switch..']'
    end

    cmd = string.format('path --add --path=[%s] %s', table.concat(path, ","), switch)
    Cmd:Exec(cmd)
end

function Path:GetPosition(Position, Increase, EstimateObjects)

    local Pos = {Cell = Position.Cell, Element = Position.Element}
    local TrackItems, Connection
    local i, NextPoint --CountDirection,
    
    if Increase >= 0 then
        i = Increase
    else
        i = -Increase
    end
    
    while i > 0 do
    
        if Increase >=0 then
            Connection = Pos.Cell.Connection[Pos.Element.Point][Pos.Cell.Connection[Pos.Element.Point].Position]
            TrackItems = Track[Connection.Element].Items
            
            if Pos.Element.Indent + i <= #TrackItems then
                Pos.Cell = Pos.Cell                               
                Pos.Element = {Point = Pos.Element.Point, Indent = Pos.Element.Indent + i}
                i = 0 
            end
            
            if Pos.Element.Indent + i > #TrackItems then
                NextPoint = Related[Connection.Point]
                i =  i - #TrackItems + Pos.Element.Indent - 1
                
                if Connection.Cell.Connection[NextPoint] ~= nil then                                     
                    Pos.Cell=Connection.Cell                    
                    Pos.Element = {Point = NextPoint, Indent = 0}
                    if EstimateObjects then                        
                        Path:EstimateObject(Increase - i, NextPoint, Connection.Point, Connection.Cell, Pos)
                    end
                else
                    Pos.Cell = Pos.Cell                               
                    Pos.Element = {Point = Pos.Element.Point, Indent = #TrackItems - 1}
                    if EstimateObjects then                        
                        Path:EstimateObject(Increase - i, NextPoint, Connection.Point, Connection.Cell, Pos)
                    end
                    i = 0
                end
            end
        end

        if Increase < 0 then
        
            if Pos.Element.Indent - i >= 0 then
                Pos.Element = {Point = Pos.Element.Point, Indent = Pos.Element.Indent - i}
                i = 0               
            end
                        
            if Pos.Element.Indent - i < 0 then                
                NextPoint = Related[Pos.Element.Point]
                if EstimateObjects then
                    Path:EstimateObject(- Increase - i + Pos.Element.Indent, NextPoint, Pos.Element.Point, Pos.Cell, Pos)
                end
                if Pos.Cell.Connection[NextPoint] ~= nil then
                    Connection = Pos.Cell.Connection[NextPoint][Pos.Cell.Connection[NextPoint].Position]                
                    i =  i - (Pos.Element.Indent + 1)
                    TrackItems = Track[Connection.Element].Items
                    Pos.Element = {Point = Connection.Point, Indent = #TrackItems}
                    Pos.Cell = Connection.Cell
                else
                    Pos.Element = {Point = Pos.Element.Point, Indent = 0}
                    i = 0
                end
            end
        end             
    end -- while
        
    if EstimateObjects then
        Pos.Element.SpeedLimit = Track[Pos.Cell.Connection[Pos.Element.Point][Pos.Cell.Connection[Pos.Element.Point].Position].Element].SpeedLimit
    end
    return Pos
end

function Path:GetPositionCoordinates(Position)
    --local x, y
    
    local Connection = Position.Cell.Connection[Position.Element.Point][Position.Cell.Connection[Position.Element.Point].Position]

    --local TrackItems = Track[Connection.Element].Items   
    local Enter = Connection.Enter

    local TrackIndent = 0
    local Cell = Position.Cell
    
    if Position.Element.Indent > 0 then
        if Enter==1 then
            TrackIndent=Position.Element.Indent
        end
        
        if Enter==2 then
            TrackIndent=#Track[Connection.Element].Items - Position.Element.Indent + 1
            Cell = Connection.Cell
        end
    end
    
    local dx = 0  
    local dy = 0
    
    if TrackIndent > 0 then
        dx = Track[Connection.Element].Items[TrackIndent][1]       
        dy = Track[Connection.Element].Items[TrackIndent][2]
    end
  
    --x = Cell.x * 10 + dx
    --y = Cell.y * 10 + dy    
    --return x, y
    return Cell.x * 10 + dx, Cell.y * 10 + dy
end

function Path:EstimateObject(Indent, OutPoint, InPoint, Cell, Position)
     
    if Cell.Switch~=nil and Cell.Switch[OutPoint]~=nil then
        if Position.OutSwitch == nil then
            Position.OutSwitch = {} 
        end
        table.insert(Position.OutSwitch, {Item = Cell.Switch[OutPoint], Indent = Indent} )   
    end
    
    if Cell.Semaphore~=nil and Cell.Semaphore[InPoint]~=nil then
        if Position.Semaphore == nil then
            Position.Semaphore = {}
        end
        table.insert(Position.Semaphore, {Item = Cell.Semaphore[InPoint], Indent = Indent})
    end
    
    if Cell.Connection[OutPoint] ~= nil and Track[Cell.Connection[OutPoint][Cell.Connection[OutPoint].Position].Element].SpeedLimit ~= nil then
        if Position.SpeedLimits == nil then
            Position.SpeedLimits = {}
        end
        Position.SpeedLimits[Track[Cell.Connection[OutPoint][Cell.Connection[OutPoint].Position].Element].SpeedLimit] = {SpeedLimit = Track[Cell.Connection[OutPoint][Cell.Connection[OutPoint].Position].Element].SpeedLimit, Distance = #Track[Cell.Connection[OutPoint][Cell.Connection[OutPoint].Position].Element].Items, Indent = Indent}
        --table.insert(Position.SpeedLimits, {SpeedLimit = Track[Cell.Connection[OutPoint][Cell.Connection[OutPoint].Position].Element].SpeedLimit, Distance = #Track[Cell.Connection[OutPoint][Cell.Connection[OutPoint].Position].Element].Items, Indent = Indent} )
    end
    
    if Cell.Connection[OutPoint] == nil then       
        Position.TrackEnd = {Indent = Indent}
        --print('End of track. Indent = ' .. Indent)
    end
end

GraphPoint = {}

function GraphPoint:new(x, y)
	Object = {x = x, y = y, In = {}, Out = {}, D = {}, F = {}}	
	self.__index = self
	return setmetatable(Object, self)
end 

