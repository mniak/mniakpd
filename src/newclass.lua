return function(ctor)
   class = {}
   function class:new()
      local o = {}
      local meta = {}
      setmetatable(o, meta)

      if ctor ~= nil then
         ctor(meta)
      end
      
      -- Getter
      function meta:__index(index)
         local getfunc = class["get_" .. index]
         if getfunc ~= nil then
            return getfunc(self)
         end
         return meta[index]
      end
      -- Setter
      function meta:__newindex(index, value)
         local setfunc = class["set_" .. index]
         if setfunc ~= nil then
            setfunc(meta, value)
            return
         end
         meta[index] = value
      end
      return o
   end
   return class
end
