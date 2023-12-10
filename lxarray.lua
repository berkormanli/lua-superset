Array = {}
Array.index = {}

setmetatable(Array, {
    __call = function(instance, elements)
        local obj = setmetatable({
            __type = "array",
            __data = {},
            length = 0,
            push = function(instance, ...)
                local args = {...}
                for i, j in ipairs(args) do
                    table.insert(instance.__data, j)
                    instance.length = instance.length + 1
                end
            end,
            pop = function(instance)
                if instance.length == 0 then return false end
                local removed = table.remove(instance.__data)
                instance.length = instance.length - 1
                return removed
            end,
            shift = function(instance)
                local removed = table.remove(instance.__data, 1)
                instance.length = instance.length - 1
                local removed
            end,
            unshift = function(instance, value)
                table.insert(instance.__data, 1, value)
                instance.length = instance.length + 1
            end,
            includes = function(instance, value)
                for _, v in ipairs(instance.__data) do
                    if v == value then
                        return true
                    end
                end
                return false
            end,
            join = function(instance, separator)
                return table.concat(instance.__data, separator)
            end,
            fill = function(instance, newValue, startIndex, endIndex)
                if (startIndex and startIndex < 1) or (endIndex and endIndex > instance.length) then return false end
                if not startIndex then startIndex = 1 end
                if not endIndex then endIndex = instance.length end
                for i = startIndex, endIndex, 1 do
                    instance.__data[i] = newValue
                end
            end,
            map = function(instance, mapCB)
                local resultArray = Array()
                for i, v in ipairs(instance.__data) do
                    resultArray:push(mapCB(v, i, instance.__data))
                end
                return resultArray
            end,
            filter = function(instance, predicateCB)
                local resultArray = Array()
                for i, v in ipairs(instance.__data) do
                    if predicateCB(v, i, instance.__data) then
                        resultArray:push(v)
                    end
                end
                return resultArray
            end,
            find = function(predicateCB)
                for i, v in ipairs(instance.__data) do
                    if predicateCB(v, i, instance.__data) then
                        return v
                    end
                end
                return false
            end,
            every = function(predicateCB)
                for i, v in ipairs(instance.__data) do
                    if not predicateCB(v, i, instance.__data) then
                        return false
                    end
                end
                return true
            end,
            some = function(predicateCB)
                for i, v in ipairs(instance.__data) do
                    if predicateCB(v, i, instance.__data) then
                        return true
                    end
                end
                return false
            end,
            findIndex = function(predicateCB)
                for i, v in ipairs(instance.__data) do
                    if predicateCB(v, i, instance.__data) then
                        return i
                    end
                end
                return false
            end,
            findLast = function(predicateCB)
                for i, v in ipairs(instance.__data) do
                    if predicateCB(v, i, instance.__data) then
                        return v
                    end
                end
                return false
            end,
            findLastIndex = function(predicateCB)
                for i = #instance.__data, 1, -1 do
                    if predicateCB(v, i, instance.__data) then
                        return i
                    end
                end
                return false
            end,
            reduce = function(accumulator, initialValue)
                local result = initialValue
                for _, value in ipairs(instance.__data) do
                    result = accumulator(result, value)
                end
                return result
            end
        }, {
            __len = function(instance)
                return instance.length
            end
        })
        -- @desc It inserts all elements if it's a predefined Array.
        if elements then
            for i, j in ipairs(elements) do
                table.insert(obj.__data, j)
                obj.length = obj.length + 1
            end
        end
        return obj
    end,
    __index = Array.index
})

local a = Array({2,4,9,8,6})

a:push(5)
a:push(4)
a:push(3)
a:push(2)
a:push(1)

a:pop()
a:push(31)
a:pop()
print(a.length)
print(#a)

local b = a:filter(function(value, index, arr)
    return index % 2 == 1
end)


