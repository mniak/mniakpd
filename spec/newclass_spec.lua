require "busted.runner"()

describe("Try to create new class", function()
   MyClass = require "newclass"(function(self)
      self.a = 'A'
   end)
   function MyClass:get_b()
      return 'B'
   end
   function MyClass:set_c(value)
      self.c = value
   end

   sut = MyClass:new()
   sut.c = 'C'
   sut.d = 'D'

   assert.are.equal('A', sut.a);
   assert.are.equal('B', sut.b);
   assert.are.equal('C', sut.c);
   assert.are.equal('D', sut.d);
   assert.are.equal(nil, sut.z);
end)

describe("Dont mix data from two classes", function()
   MyClass1 = require "newclass"(function(self)
      self.v = 'D1'
   end)
   MyClass2 = require "newclass"(function(self)
      self.v = 'D2'
   end)
   MyClass3 = require "newclass"(function(self)
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
   MyClass = require "newclass"(function(self)
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
