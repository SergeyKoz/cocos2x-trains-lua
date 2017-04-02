Train = {} 
Train.Cars = {}

function Train:new()
    Object = {Cars = {}, SpeedProgram = {Speeds = {}, Acceleration = 1, SpeedLimit = 0, SpeedLimits = {}, MaxSpeed = 0}}
    self.__index = self    
    return setmetatable(Object, self) 
end

function Train:Instance()
    return self
end

function Train:AddCar(CarItem)    
    if self.Cars == nil then
        self.Cars={}
    end
    if CarItem.Type.traction ~= nil and CarItem.Type.traction > 0 then
        self.SpeedProgram.MaxSpeed = self.SpeedProgram.MaxSpeed + CarItem.Type.traction
        self.SpeedProgram.Length = math.ceil(self.SpeedProgram.MaxSpeed / self.SpeedProgram.Acceleration) * 2
        self.SpeedProgram.Limit = self.SpeedProgram.Length / 3
    end
    table.insert(self.Cars, CarItem)   
end

function Train:SetPosition(Position) 
    if self.Cars ~= nil then
        for c = 1, #self.Cars do
            Position = self.Cars[c]:SetPosition(Position)          
        end
    end
end

function Train:GetSpeed()

    local Program=self.SpeedProgram

    local k = 1
    if self.Direction == Back then
        k = -1
    end

    local function GetNextPointer(Pointer, Length)    
        if Pointer == Length then            
            return 1
        else
            return Pointer + 1
        end       
    end

    local function GetPrevPointer(Pointer, Length)       
        if Pointer == 1 then            
            return Length
        else
            return Pointer - 1
        end        
    end

    local function CheckSpeed(Speed)
        local Checked = true
        local Program = self.SpeedProgram


        local function SlowDownProgram(NextPosition, Indent, SpeedLimit)
            --print('Slow Down')
            local Program = self.SpeedProgram
            --local k = k
            local SpeedItems = {}                        
            local LookPointer = Program.LookPointer 
            local LookPointers = Program.LookPointers
            local PrevSpeed = k * Program.Speeds[LookPointer].Speed + Indent
            local NextSpeed = SpeedLimit 
            local c = 1
            local p = PrevSpeed
            SpeedItems[c]= k * NextSpeed

            while PrevSpeed - NextSpeed > Program.Acceleration do
                while p > 0 do
                    NextSpeed = NextSpeed + Program.Acceleration 
                    c = c + 1
                    SpeedItems[c] = k * NextSpeed     
                    p = p - NextSpeed
                end
                LookPointer = GetPrevPointer(LookPointer, Program.Length)
                LookPointers = LookPointers - 1                            
                PrevSpeed = k * Program.Speeds[LookPointer].Speed
                p = PrevSpeed + p 
            end

            if LookPointers >= 0 then
                if p > 0 and PrevSpeed == p then
                    c = c + 1
                    SpeedItems[c] = k * PrevSpeed 
                    p = 0                
                end
                Program.LookPointers = LookPointers - 1                        
                LookPointer = GetPrevPointer(LookPointer, Program.Length)                        
            else
                Program.LookPointers = 0
                LookPointer = Program.Pointer 
            end

            for c = #SpeedItems, 1, -1 do                        
                if p > 0 and (k * SpeedItems[c] <= p and k * SpeedItems[c] + Program.Acceleration > p) then
                    LookPointer = GetNextPointer(LookPointer, Program.Length)
                    Program.LookPointers = Program.LookPointers + 1
                    Program.Speeds[LookPointer].Speed = k * p
                    p = 0                    
                end
                LookPointer = GetNextPointer(LookPointer, Program.Length)
                Program.LookPointers = Program.LookPointers + 1
                Program.Speeds[LookPointer].Speed = SpeedItems[c]                
            end

            Program.LookPointer = LookPointer

            if p > 0 then
                Program.LookPosition = Path:GetPosition(Program.LookPosition, k * (Indent + SpeedLimit - p), false)                
            else
                Program.LookPosition = Path:GetPosition(Program.LookPosition, k * (Indent + SpeedLimit) , false)
            end

            --__DebudTrackMoving(self)

            Program.SpeedLimit = SpeedLimit           
        end
        -- get analyze position 
        local NextPosition = Path:GetPosition(Program.LookPosition, Speed, true)

        -- Switches
        if NextPosition.OutSwitch ~= nil then
            for c = 1, #NextPosition.OutSwitch do            
                NextPosition.OutSwitch[c].Item:AddTrainListener(self)
            end
        end
        
        -- Semaphores
        if NextPosition.Semaphore ~= nil then
            local StopCounted = false
            for j = 1, #NextPosition.Semaphore do            
                NextPosition.Semaphore[j].Item:AddTrainListener(self)      
                if (NextPosition.Semaphore[j].Item.Position == Stop or NextPosition.Semaphore[j].Item.Position == Reverse) then

                    local Indent
                    if self.Direction == Forward then
                        Indent = NextPosition.Semaphore[j].Indent
                    else
                        Indent = NextPosition.Semaphore[j].Indent
                    end

                    SlowDownProgram(NextPosition, Indent, 0)                    
                    if NextPosition.Semaphore[j].Item.Position == Reverse then
                        Program.Speeds[Program.LookPointer].Speed = - k * Program.Acceleration                   
                        --NextPosition.Semaphore[j].Item:RemoveTrainListener(self)                        
                    end                    
                    Checked = false
                end -- Stop semafore processing
            end -- for semafores
        end
                
        -- end of track 
        if Checked then
            if NextPosition.TrackEnd ~= nil then            
                SlowDownProgram(NextPosition, NextPosition.TrackEnd.Indent, 0)
                Checked = false
            end
            
            -- Speed limetes
            if Checked and NextPosition.SpeedLimits ~= nil then
                local l = Program.MaxSpeed
                for s, Item in pairs(NextPosition.SpeedLimits) do
                    if s < l then
                        l = s
                    end        
                end
    
                if l < Program.MaxSpeed then
    
                    if l < Program.SpeedLimit and k * Program.Speeds[Program.LookPointer].Speed > l then
                        local Indent = NextPosition.SpeedLimits[l].Indent
                        SlowDownProgram(NextPosition, Indent, l)
                        Checked = false
                    end
                    
                    local Distance                
                    for s, Item in pairs(NextPosition.SpeedLimits) do
                        if s < Program.MaxSpeed then  
                            Distance = Item.Distance + s
                            if self.Cars ~= nil then
                                for j = 1, #self.Cars do
                                    Distance = Distance + self.Cars[j].Type.base + 4        
                                end
                            end
                            Program.SpeedLimits[s] = {Distance = Distance}
                        end
                    end
    
                end                      
            end
    
            if Checked then
                Program.LookPointer = GetNextPointer(Program.LookPointer, Program.Length)
                Program.LookPointers = Program.LookPointers + 1            
                Program.LookPosition = NextPosition            
                Program.Speeds[Program.LookPointer].Speed = Speed
                
                if Program.SpeedLimits[Program.SpeedLimit] ~= nil then
                    local Distance
                    local SpeedLimit = Program.MaxSpeed
                    for s, Item in pairs(Program.SpeedLimits) do
                        Distance = Item.Distance - k * Speed
                        if Distance > 0 then
                            if s < SpeedLimit then
                                SpeedLimit = s
                            end                    
                            Program.SpeedLimits[s] = {Distance = Distance}
                        else
                            Program.SpeedLimits[s] = nil
                        end
                    end       
                    Program.SpeedLimit = SpeedLimit
                end
                
                --__DebudTrackMoving(self)
    
            end
        end

        return Checked
    end -- CheckSpeed

    local function UpdateSpeedProgram()
        local Program = self.SpeedProgram
        
        local f
        if Program.LookPointers < Program.Limit then
            --update speed limit
            if k * Program.SpeedLimit ~= Program.Speeds[Program.LookPointer].Speed then 
                --print('!= SpeedLimit')
                -- если скорость поезда не равна SpeedLimit               
                local CurrentSpeed = Program.Speeds[Program.LookPointer].Speed            
                f=true
                if CurrentSpeed < k * Program.SpeedLimit then
                    --print('inc')
                    -- увеличиваем до SpeedLimit
                    while k * Program.SpeedLimit > CurrentSpeed and f do
                        if CurrentSpeed + Program.Acceleration > Program.SpeedLimit then
                            CurrentSpeed = k * Program.SpeedLimit
                        else
                            CurrentSpeed = CurrentSpeed + Program.Acceleration
                        end
                        if not CheckSpeed(CurrentSpeed) then
                            f=false 
                        end                        
                    end
                else
                    -- уменьшаем до SpeedLimit
                    --print('dec')
                    while k * Program.SpeedLimit < CurrentSpeed and f do
                        if CurrentSpeed - Program.Acceleration < k * Program.SpeedLimit then
                            CurrentSpeed = k * Program.SpeedLimit
                        else
                            CurrentSpeed = CurrentSpeed - Program.Acceleration
                        end
                        
                        if not CheckSpeed(CurrentSpeed) then
                            f=false 
                        end
                    end
                end
            else
                -- если скорость постояная
                local NextSpeed = k * Program.SpeedLimit
                f = true
                while Program.LookPointers < Program.Limit and f do
                    if not CheckSpeed(NextSpeed) then
                        f=false 
                    end                    
                end
            end
        end         
    end -- UpdateSpeedProgram
    
    UpdateSpeedProgram()
    
    if Program.Speeds[Program.Pointer].Speed ~= 0 then 

        Program.Pointer = GetNextPointer(Program.Pointer, Program.Length)
        Program.LookPointers = Program.LookPointers - 1
        
        if self.Direction == Back and Program.Speeds[Program.Pointer].Speed > 0 then
            self.Direction = Forward            
            self:SpeedProgramReset()
            Program.LookPosition = Path:GetPosition(self.Cars[1].Axis1.Position, 2 + Program.Acceleration) 
        end
         
        if self.Direction == Forward and Program.Speeds[Program.Pointer].Speed < 0 then
            self.Direction = Back
            self:SpeedProgramReset()
            Program.LookPosition = Path:GetPosition(self.Cars[#self.Cars].Axis2.Position, - 2 - Program.Acceleration)
        end        
    end
    
    --print('v = ' .. Program.Speeds[Program.Pointer].Speed)
    return Program.Speeds[Program.Pointer].Speed
end

function Train:SpeedProgramReset()
    --print('reset')
    local sp = self.SpeedProgram    
    if sp.Speeds[sp.Pointer].Speed == 0 then
        if self.Direction == Forward then
        	sp.Speeds[sp.Pointer].Speed = sp.Acceleration
        else
            sp.Speeds[sp.Pointer].Speed = - sp.Acceleration
        end        
    end
    sp.LookPointer = sp.Pointer 
    sp.LookPointers = 0 
    if self.Direction == Forward then
        sp.LookPosition = Path:GetPosition(self.Cars[1].Axis1.Position, 2)
    else
        sp.LookPosition = Path:GetPosition(self.Cars[#self.Cars].Axis2.Position, - 2)
    end
    -- get speed

    local TrainLenght = 0
    if self.Cars ~= nil then
        for j = 1, #self.Cars do
            TrainLenght = TrainLenght + self.Cars[j].Type.base + 4        
        end
        TrainLenght = TrainLenght - 2
    end
    
    local TrainPosition    
    if self.Direction == Forward then
        TrainPosition = Path:GetPosition(self.Cars[#self.Cars].Axis2.Position, TrainLenght, true)
    else
        TrainPosition = Path:GetPosition(self.Cars[1].Axis1.Position, - TrainLenght, true)
    end
    
   local SpeedLimit = sp.MaxSpeed   
   if TrainPosition.SpeedLimits ~= nil then
        local Distance            
        for s, Item in pairs(TrainPosition.SpeedLimits) do
            if s < sp.MaxSpeed then
                if s < SpeedLimit then
                    SpeedLimit = s
                end   
                Distance = Item.Distance + s + Item.Indent           
                sp.SpeedLimits[s] = {Distance = Distance}
            end
        end 
    end  
    sp.SpeedLimit = SpeedLimit
end

function Train:GetMove(Move)
    if self.Cars ~= nil then
        local Estimate
        for c = 1, #self.Cars do            
            if c == 1 or c == #self.Cars then
                Estimate = true
            else
                Estimate = false 
            end
            self.Cars[c]:GetMove(Move, Estimate)            
        end        
    end
end

function Train:RunMove()

    for c = 1, #self.Cars do
        self.Cars[c]:RunMove()          
    end
    
    local Position
    if self.Direction == Forward then
        Position = self.Cars[1].Axis1.Position
    else
        Position = self.Cars[#self.Cars].Axis2.Position
    end
    
    if Position.OutSwitch ~= nil then
        for c = 1, #Position.OutSwitch do            
            Position.OutSwitch[c].Item:RemoveTrainListener(self)         
        end
    end

    if Position.Semaphore ~= nil then
        for c = 1, #Position.Semaphore do   
            if Position.Semaphore[c].Item.Position ~= Stop then         
                Position.Semaphore[c].Item:RemoveTrainListener(self) 
            end        
        end                        
    end     

end

function Train:Move()
    if self.SpeedProgram.MaxSpeed > 0 then
        self:RunMove()
        self:GetMove(self:GetSpeed())        
    end
end

function Train:Init()
    if self.Cars ~= nil and self.SpeedProgram.MaxSpeed > 0 and self.Cars[1].Move == nil then    
        local i           
        for i = 1, self.SpeedProgram.Length do
            self.SpeedProgram.Speeds[i] = {}
        end
        self.SpeedProgram.Pointer = 1 
        self.SpeedProgram.Speeds[self.SpeedProgram.Pointer].Speed = 0            
        self:SpeedProgramReset()        
        self:GetMove(self:GetSpeed())
    end
end
