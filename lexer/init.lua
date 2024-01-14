--[[local Class = require("class")
local Pos = require("./classes/pos")
local Array = require("./classes/array")
local Token = require("./classes/token")

local clock = os.clock
local function sleep(n)  -- seconds
   local t0 = clock()
   while clock() - t0 <= n do
   end
end

local token_types = {
    number = "%d",
    plus = "+",
    minus = "-",
    times = "*",
    divide = "/",
    lparen = "%(",
    rparen = "%)",
}

local whitespace_array = Array({' ', '\t', ' '})

function createTokens(code)
    local lexer = Lexer(code, token_types)
    return lexer:createTokens()
end

-- Define the Lexer class
Lexer = Class()
--[[
    Lexer
]]
--[[
function Lexer:__init(code, types)
    self.code = code
    self.types = types
    self.pos = Pos(0, 0, 0, code);
    self.slice = code
end

function Lexer:advance(n)
    self.pos:advance(n)
    self.slice = self.code:sub(self.pos:getIdx(), string.len(self.code))
    while whitespace_array:includes(self.slice[0]) do
        self:advance(1)
    end
end

function Lexer:createTokens()
    local tokens = Array({})

    while self.slice do
        local token = nil

        for _type, value in pairs(self.types) do
            --print(self.slice, value)
            local e = string.match(self.slice, value)
            --print(e)
            if e then
                token = Token(_type, e[1])
                break
            end
        end

        if token == nil then
            return ("error: Token is nil")
        end
        --print(token.value, token:getLength())
        tokens:push(token)
        self:advance(token:getLength())
        sleep(5)
    end

    return tokens
end]]

local f = assert(io.open("./test.ay", "r"))

local fileContent = f:read("*all")

--createTokens(fileContent)

local lex = require('./lexer/lexer')
local json = require('json')

local listOfLex = lex(fileContent)

local jsonOutput = io.open("output2.json", "w+")
io.output(jsonOutput)
local str = json.encode(listOfLex)
local errmsg = io.write(str)
local bool = io.close(jsonOutput)

print(errmsg, bool)