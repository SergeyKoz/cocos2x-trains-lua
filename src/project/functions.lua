-- A function in Lua similar to PHP's print_r, from http://luanet.net/lua/function/print_r
function print_r ( t ) 
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t,"  ")
end

-- explode(seperator, string)
function explode(d,p)
  local t, ll
  t={}
  ll=0
  if(#p == 1) then return {p} end
    while true do
      l=string.find(p,d,ll,true) -- find the next d in the string
      if l~=nil then -- if "not not" found then..
        table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
            ll=l+1 -- save just after where we found it for searching next time.
        else
        table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
        break -- Break at end, as it should be, according to the lua manual.
      end
    end
  return t
end

-- debug

__points = {}
__pointer = 1
__lookpointer = 2

function __DebudTrackMoving(Train)

    local function GetNextPointer(Pointer, Length)
        local i
        if Pointer == Length then            
            i = 1
        else
            i = Pointer + 1
        end
        return i
    end

    local function GetPrevPointer(Pointer, Length)
        local i
        if Pointer == 1 then            
            i = Length
        else
            i = Pointer - 1
        end
        return i
    end
            
    local tx, ty = Path:GetPositionCoordinates(Train.SpeedProgram.LookPosition)
    DebugDraw:drawDot( cc.p(tx * 2, ty *2), 2, cc.c4b(1,0,1,1))                
    __addPoint(tx * 2, ty *2)
    
    if Train.SpeedProgram.Pointer ~= Train.SpeedProgram.LookPointer then
   
        local __l = 0
        local __lp = GetNextPointer(Train.SpeedProgram.Pointer, Train.SpeedProgram.Length)
        while __lp ~= Train.SpeedProgram.LookPointer do
            if Train.SpeedProgram.Speeds[__lp].Speed ~= nil then                
                __l = __l + Train.SpeedProgram.Speeds[__lp].Speed
            end
            __lp = GetNextPointer(__lp, Train.SpeedProgram.Length)
        end 
        local __pos
        if Train.Direction == Forward then
            __pos = Path:GetPosition(Train.Cars[1].Axis1.Position, __l +  2)
        else
            __pos = Path:GetPosition(Train.Cars[#Train.Cars].Axis2.Position, __l - 2)
        end
        tx, ty = Path:GetPositionCoordinates(__pos)
        DebugDraw:drawDot( cc.p(tx * 2, ty *2), 2, cc.c4b(255,0,1,1))                
        __addPoint(tx * 2, ty *2)  
    end  
end


function __addPoint(x, y)
    local _x, _y
    local function __GetNextPointer(Pointer)
        local i
        if Pointer == 20 then            
            i = 1
        else
            i = Pointer + 1
        end
        return i
    end
    
    local function __GetPrevPointer(Pointer)
        local i
        if Pointer == 1 then            
            i = 20
        else
            i = Pointer - 1
        end
        return i
    end
    __points[__pointer] = {x = x, y = y}    
    __pointer = __GetNextPointer(__pointer)
    
    if __points[__lookpointer] ~= nil then
        _x = __points[__lookpointer].x
        _y = __points[__lookpointer].y
        DebugDraw:drawDot( cc.p(_x, _y), 2, cc.c4b(1,1,1,1))
    end 
    __lookpointer = __GetNextPointer(__lookpointer)   
end

