require "busted.runner"()

describe("Try to create new class", function()
   MyClass = require "newclass"()
   function MyClass:get_a()
      return 'A'
   end
   function MyClass:set_b(value) 
      self.b = value
   end

   sut = MyClass:new()
   sut.b = 'B'
   sut.c = 'C'

   assert.are.equal('A', sut.a);
   assert.are.equal('B', sut.b);
   assert.are.equal('C', sut.c);
   assert.are.equal(nil, sut.z);
end);


describe("Dont mix data from two classes", function()
   MyClass1 = require "newclass"()
   MyClass2 = require "newclass"()

   m1 = MyClass1:new()
   m2 = MyClass2:new()

   m1.v = 'V1'
   m2.v = 'V2'

   assert.are.equal('V1', m1.v);
   assert.are.equal('V2', m2.v);  
end);

describe("Dont mix data from two instances", function()
   MyClass = require "newclass"()

   m1 = MyClass:new()
   m2 = MyClass:new()

   m1.v = 'V1'
   m2.v = 'V2'

   assert.are.equal('V1', m1.v);
   assert.are.equal('V2', m2.v);  
end);
