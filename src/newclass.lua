return function(ctor)
   local class = {}
   function class:new()
      local meta = {}
      -- Getter
      function meta:__index(index)
         local classValue =rawget(class,  index)
         if type(classValue) == "function" then
            local oldself = self
            return function(...)
               return classValue(oldself, ...)
            end
         end
         local getter = rawget(class, "get_" .. index)
         if getter ~= nil then
            return getter(self)
         end
         local _value = rawget(self,"_".. index)
         if _value ~= nil then
            return _value
         end
         return rawget(self, index)
      end
      -- Setter
      function meta:__newindex(index, value)
         local setter = rawget(class, "set_" .. index)
         if setter ~= nil then
            setter(self, value)
            return
         end
         local getter = rawget(class, "get_" .. index)
         if getter ~= nil then
            rawset(self, "_".. index, value)
            return
         end
         rawset(self, index, value)
      end
      
      local o = {}
      setmetatable(o, meta)
      if ctor ~= nil then
         ctor(o)
      end

      return o
   end
   return class
end
