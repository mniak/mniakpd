require "busted.runner"()
require "pitch_class"

describe("Basic test", function()
   pc = PitchClass:new()

   describe("Assert initial values from constructor are being set", function()
      assert.are.equal(1, pc.step)
      assert.are.equal(0, pc.alteration)
   end)

end)

describe("Step", function()

   describe("Normal values should work", function()
      pc = PitchClass:new()

      pc.step = 1
      assert.are.equal(1, pc.step)

      pc.step = 2
      assert.are.equal(2, pc.step)

      pc.step = 3
      assert.are.equal(3, pc.step)

      pc.step = 4
      assert.are.equal(4, pc.step)

      pc.step = 5
      assert.are.equal(5, pc.step)

      pc.step = 6
      assert.are.equal(6, pc.step)

      pc.step = 7
      assert.are.equal(7, pc.step)
   end)

   describe("Bigger values should be normalized", function()
      pc = PitchClass:new()

      pc.step = 8
      assert.are.equal(1, pc.step)

      pc.step = 9
      assert.are.equal(2, pc.step)

      pc.step = 10
      assert.are.equal(3, pc.step)

      pc.step = 11
      assert.are.equal(4, pc.step)

      pc.step = 12
      assert.are.equal(5, pc.step)

      pc.step = 13
      assert.are.equal(6, pc.step)

      pc.step = 14
      assert.are.equal(7, pc.step)

      pc.step = 15
      assert.are.equal(1, pc.step)

   end)

   describe("Zero or negative values should do nothing", function()
      pc = PitchClass:new()

      for goodValue = 1, 6 do
         for badValue = -1, -20, -1 do
            pc.step = goodValue
            pc.step = badValue
            assert.are.equal(goodValue, pc.step)
         end
      end
   end)

   describe("Decimals should be rounded", function()
      pc = PitchClass:new()
      for v = 1, 4, 0.123 do
         pc.step = v
         assert.are.equal(0, pc.step % 1)
         assert.is.truthy(pc.step >= math.floor(v))
         assert.is.truthy(pc.step <= math.ceil(v))
      end
   end)
end)

describe("Alteration", function()

   describe("When value is in range store the same", function()
      pc = PitchClass:new()

      pc.alteration = -2
      assert.are.equal(-2, pc.alteration)

      pc.alteration = -1
      assert.are.equal(-1, pc.alteration)

      pc.alteration = 0
      assert.are.equal(0, pc.alteration)

      pc.alteration = 1
      assert.are.equal(1, pc.alteration)

      pc.alteration = 2
      assert.are.equal(2, pc.alteration)

   end)

   describe("When value is smaller than limit, keep min value", function()
      pc = PitchClass:new()

      for v = -12, -2 do
         pc.alteration = 0
         pc.alteration = v
         assert.are.equal(-2, pc.alteration)
      end
   end)

   describe("When value is greater than limit, keep max value", function()
      pc = PitchClass:new()

      for v = 2, 12 do
         pc.alteration = 0
         pc.alteration = v
         assert.are.equal(2, pc.alteration)
      end
   end)

   describe("Decimals should be rounded", function()
      pc = PitchClass:new()
      for v = -2, 2, 0.123 do
         pc.alteration = v
         assert.are.equal(0, pc.alteration % 1)
         assert.is.truthy(pc.alteration >= math.floor(v))
         assert.is.truthy(pc.alteration <= math.ceil(v))
      end
   end)
end)

describe("Random", function()
   describe("Steps should have a good distribution", function()
      steps = {}
      for i = 1, 7 * 5 do
         pc = PitchClass:random()
         steps[pc.step] = true
      end
      for i = 1, 7 do
         pc = PitchClass:random()
         assert.is.truthy(steps[i])
      end
   end)

   describe("Alterations should have a good distribution", function()
      alterations = {}
      for i = 1, 5 * 5 do
         pc = PitchClass:random()
         alterations[pc.alteration] = true
      end
      for i = -1, -2 do
         pc = PitchClass:random()
         assert.is.truthy(alterations[i])
      end
   end)
end)

describe("Pretty Name", function()
   describe("Without alterations", function()
      pc = PitchClass:new()
      pc.alteration = 0
      names = {"C", "D", "E", "F", "G", "A", "B"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name_pretty()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 1 flat", function()
      pc = PitchClass:new()
      pc.alteration = -1
      names = {"C♭", "D♭", "E♭", "F♭", "G♭", "A♭", "B♭"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name_pretty()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 2 flats", function()
      pc = PitchClass:new()
      pc.alteration = -2
      names = {"C♭♭", "D♭♭", "E♭♭", "F♭♭", "G♭♭", "A♭♭", "B♭♭"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name_pretty()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 1 sharp", function()
      pc = PitchClass:new()
      pc.alteration = 1
      names = {"C♯", "D♯", "E♯", "F♯", "G♯", "A♯", "B♯"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name_pretty()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 2 sharps", function()
      pc = PitchClass:new()
      pc.alteration = 2
      names = {"C♯♯", "D♯♯", "E♯♯", "F♯♯", "G♯♯", "A♯♯", "B♯♯"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name_pretty()
         assert.are.equal(expected, actual)
      end
   end)
end)

describe("Simple Name", function()
   describe("Without alterations", function()
      pc = PitchClass:new()
      pc.alteration = 0
      names = {"C", "D", "E", "F", "G", "A", "B"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 1 flat", function()
      pc = PitchClass:new()
      pc.alteration = -1
      names = {"Cb", "Db", "Eb", "Fb", "Gb", "Ab", "Bb"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 2 flats", function()
      pc = PitchClass:new()
      pc.alteration = -2
      names = {"Cbb", "Dbb", "Ebb", "Fbb", "Gbb", "Abb", "Bbb"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 1 sharp", function()
      pc = PitchClass:new()
      pc.alteration = 1
      names = {"C#", "D#", "E#", "F#", "G#", "A#", "B#"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name()
         assert.are.equal(expected, actual)
      end
   end)

   describe("With 2 sharps", function()
      pc = PitchClass:new()
      pc.alteration = 2
      names = {"C##", "D##", "E##", "F##", "G##", "A##", "B##"}
      for i = 1, 7 do
         pc.step = i
         expected = names[i]
         actual = pc.name()
         assert.are.equal(expected, actual)
      end
   end)
end)
