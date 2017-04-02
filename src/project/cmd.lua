Cmd={}
Cmd.History = {}

function Cmd:Exec(cmdline) 
    --parse command
    local command, opts, args
    command, opts, args = Cmd:ParseCmd(cmdline)
    --print(cmdline)
    
    if command~='' then        
        Cmd[command](nil, opts, args)
    end   
end

function Cmd:ParseCmd(cmdline)
    local items = explode(" ", cmdline)    
    local command = items[1]    
    local options = {}        
    local args={}      
    local caption, value, pos    
    for c = 2, #items do
        if items[c] ~='' then
            if string.sub(items[c], 0, 2)=='--' then
                pos=string.find(items[c], "=")
                if pos~=nil then
                    caption = string.sub(items[c], 3, pos - 1)
                    value = string.sub(items[c],  pos + 1)
                    if caption~='' then
                        options[caption]=value                           
                    end
                else
                    caption = string.sub(items[c], 3)
                    if caption~='' then
                        options[caption]=''                            
                    end
                end
            else
                table.insert(args, items[c])
            end
        end
    end        
    return command, options, args
end

function Cmd:path(opts, args)

    if opts.add ~= nil then        
        local Path=json.decode(opts.path)        
        local Game = GameField:Instance()
        
        local i
        for c = 1, #Path do
            i=Path[c]
            Game:getCell(i.from.x, i.from.y):Connect(Game:getCell(i.to.x, i.to.y), i.point)
        end
        if opts.switch~=nil then        
            local Switch=json.decode(opts.switch)
            for c = 1, #Switch do
                i=Switch[c]
                Game:getCell(i.cell.x, i.cell.y):SetSwitch(i.point)
            end 
        end
    end 
    
    if opts.remove ~= nil then
        print('remove')
    end    
end 

function Cmd:semaphore(opts, args)
    if opts.add ~= nil then
        GameField:Instance():getCell(tonumber(opts.x), tonumber(opts.y)):SetSemaphore(tonumber(opts.point))
    end 
    
    if opts.remove ~= nil then
        print('remove')
    end

end
