require "busted.runner"()

local newclass = require "newclass"

describe("Test getters and setters", function()

   describe("Simple scenario", function()
      MyClass = newclass()

      sut = MyClass:new()
      assert.are.equal(nil, sut.a)

      sut.a = 'value A'
      assert.are.equal('value A', sut.a)
   end)

   describe("With constructor", function()
      MyClass = newclass(function(self)
         self.b = 'initial value of B'
      end)

      sut = MyClass:new()
      assert.are.equal('initial value of B', sut.b);

      sut.b = 'new value of B'
      assert.are.equal('new value of B', sut.b)
   end)

   describe("With explicit getter returning static value", function()
      MyClass = newclass()
      function MyClass:get_c(value)
         return 'C: fixed value'
      end

      sut = MyClass:new()
      assert.are.equal('C: fixed value', sut.c)

      sut.c = 'attempt to set value of C'
      assert.are.equal('C: fixed value', sut.c)
   end)

   describe("With explicit setter setting inner value", function()
      MyClass = newclass()
      function MyClass:set_d(value)
         self._d = value
      end

      sut = MyClass:new()
      assert.are.equal(nil, sut._d)

      sut.d = 'new value of D'
      assert.are.equal('new value of D', sut.d)
   end)

end)

describe("Dont mix data from two classes", function()
   MyClass1 = newclass(function(self)
      self.v = 'D1'
   end)
   MyClass2 = newclass(function(self)
      self.v = 'D2'
   end)
   MyClass3 = newclass(function(self)
      self.v = 'D3'
   end)

   m1 = MyClass1:new()
   m2 = MyClass2:new()
   m3 = MyClass3:new()

   m2.v = 'V2'
   m3.v = 'V3'

   assert.are.equal('D1', m1.v);
   assert.are.equal('V2', m2.v);
   assert.are.equal('V3', m3.v);
end)

describe("Dont mix data from two instances", function()
   MyClass = newclass(function(self)
      self.v = 'D0'
   end)
   m1 = MyClass:new()
   m2 = MyClass:new()
   m3 = MyClass:new()

   m2.v = 'V2'
   m3.v = 'V3'

   assert.are.equal('D0', m1.v);
   assert.are.equal('V2', m2.v);
   assert.are.equal('V3', m3.v);
end)
