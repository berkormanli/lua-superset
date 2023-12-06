local Class = require("class")

-- Define the Pos class
Pos = Class()
--[[
    Pos
]]

function Pos:__init(idx, ln, col, code)
    self.idx = idx
    self.ln = ln
    self.col = col
    self.code = code
end

function Pos:advance(n)
    for i = 1, (n or 2), 1 do
        self.idx = self.idx + 1
        self.col = self.col + 1
        if self.code[self.idx] == '\n' then
            self.col = 0
            self.ln = self.ln + 1
        end
    end
end

function Pos:clone()
    return Pos(self.idx, self.ln, self.col, self.code)
end

function Pos:getIdx()
    return self.idx
end

return Pos