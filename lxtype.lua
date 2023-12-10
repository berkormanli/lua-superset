local _type = type

-- Primitive types are: nil, boolean, number, string, userdata, function, thread, and table

_G.type = function(arg)
    if _type(arg) ~= "table" then
        return _type(arg)
    else
        return arg.__type and arg.__type or "table"
    end
end