--[[
    interface {{interfaceName}} {
        x: string,
        y: string,
        price: number
    }
]]

local _type = type

-- Primitive types are: nil, boolean, number, string, userdata, function, thread, and table

_G.type = function(arg)
    if _type(arg) ~= "table" then
        return _type(arg)
    else
        return arg.__type and arg.__type or "table"
    end
end

Interface = {}
Interface.index = {}

setmetatable(Interface, {
    __call = function(instance, interfaceName, properties)
        local obj = setmetatable({
            __type = "interface",
            __typeName = interfaceName,
            __properties = properties,
        },{
            --- @desc lhs: Left hand side, rhs: Right hand side
            __bor = function(lhs, rhs)
                print(lhs.__type, rhs.__type)
                return "did it"
            end,
            __band = function(lhs, rhs)
            
            end,
            __eq = function(lhs, rhs)
                --- if both are interfaces
                if type(lhs) == "interface" and type(rhs) == "interface" then
                    for key, value in pairs(lhs.__properties) do
                        if not rhs.__properties[key] then return false end
                        if (type(value) ~= "table" and type(value) ~= "nil") and rhs.__properties[key] ~= value then return false
                        elseif type(value) == "table" and type(rhs.__properties[key]) ~= type(value) then return false end
                    end
                elseif type(lhs) == "interface" and type(rhs) == "table" then
                    
                elseif type(lhs) == "table" and type(rhs) == "interface" then
                    
                end
                return true
            end
        })
        return obj
    end,
    __index = Interface.index
})

local additionalInterface = Interface("additional", {
    additionaldata = "string"
})
local additionalInterface2 = Interface("additional2", {
    additionaldata = "string"
})

local a = Interface("custom1", {
    x = "number",
    y = "number",
    data = "string",
    additional = additionalInterface
})

local b = Interface("custom2", {
    x = "number",
    y = "number",
    data = "string",
    additional = additionalInterface2
})

print(a == b)