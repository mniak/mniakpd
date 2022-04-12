local rand = require "openssl.rand"

function random_range(min, max)
   return rand.uniform(max - min) + min
end

function random_choice(items)
   index0 = rand.uniform(#items - 1)
   return items[index0 + 1]
end

function truncate_range(value, min, max)
   return math.floor(math.min(math.max(value, min), max))
end
