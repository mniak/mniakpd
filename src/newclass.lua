return function(defaults)
   class = {}
   function class:new()
      local o = {}
      local meta = defaults or {}

      function meta:__index(index)
         local getfunc = class["get_" .. index]
         if getfunc ~= nil then
            return getfunc(self)
         end
         return meta[index]
      end
      function meta:__newindex(index, value)
         local setfunc = class["set_" .. index]
         if setfunc ~= nil then
            setfunc(meta, value)
         end
         meta[index] = value
      end

      setmetatable(o, meta)
      return o
   end
   return class
end
