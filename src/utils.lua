local rand = require "openssl.rand"

function random_range(min, max)
   return rand.uniform(max - min + 1) + min
end

function random_choice(items)
   index0 = rand.uniform(#items - 1)
   return items[index0 + 1]
end

function truncate_range(value, min, max)
   return math.floor(math.min(math.max(value, min), max))
end

function utf8_sub(text, i, j)
   if text == nil then
      return nil
   elseif text == "" then
      return ""
   end
   
   i = utf8.offset(text, i)
   if j ~= nil then
      j = utf8.offset(text, j + 1) - 1
   end
   return string.sub(text, i, j)
end
