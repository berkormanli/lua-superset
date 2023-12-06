local Class = require("class")

-- Define the Token class
---@class Token
---@field type string
---@field value string
Token = Class()
--[[
    Token
]]

-- Constructor
--- func desc
---@param _type string
---@param value string
function Token:__init(_type, value)
    print(_type, value)
    self.type = _type
    self.value = value
end

function Token:tostring()
    return string.format("%s: %s", self.type, self.value)
end

--- getValue func
---@return string
function Token:getValue()
    return self.value
end

function Token:getLength()
    return self.value and string.len(self.value) or 0
end

return Token