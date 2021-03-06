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
      function MyClass:get_c()
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
      assert.are.equal(nil, sut.d)

      sut.d = 'new value of D'
      assert.are.equal('new value of D', sut._d)
      assert.are.equal('new value of D', sut.d)
   end)

   describe("With explicit getter and setter using underlying field", function()
      MyClass = newclass()
      function MyClass:get_e()
         return self._e
      end
      function MyClass:set_e(value)
         self._e = value
      end
    
      sut = MyClass:new()
      assert.are.equal(nil, sut.e)
      assert.are.equal(nil, sut._e)

      sut.e = 'new value of E'
      assert.are.equal('new value of E', sut.e)
      assert.are.equal('new value of E', sut._e)
   end)

   describe("With constructor and getter and setter using underlying field", function()
      MyClass = newclass(function(self)
         self._f = "initial value of F"
      end)
      function MyClass:get_f()
         return self._f
      end
      function MyClass:set_f(value)
         self._f = value
      end
    
      sut = MyClass:new()
      assert.are.equal('initial value of F', sut.f)
      assert.are.equal('initial value of F', sut._f)

      sut.f = 'new value of F'
      assert.are.equal('new value of F', sut.f)
      assert.are.equal('new value of F', sut._f)
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


describe("Dont mix methods from two classes", function()
   MyClass1 = newclass(function(self)
      self.inner_value = 0      
   end)
   function MyClass1:do_something()
      self.inner_value = self.inner_value + 2
      return "result from class 1"
   end
   MyClass2 = newclass(function(self)
      self.value = 1    
   end)
   function MyClass2:do_something()
      self.value = self.value + 3
      return "result from class 2"
   end

   m1 = MyClass1:new()
   m2 = MyClass2:new()

   assert.are.equal(0, m1.inner_value);
   assert.are.equal(1, m2.value);

   r1 = m1.do_something()
   assert.are.equal("result from class 1", r1)

   r2 = m2.do_something()
   assert.are.equal("result from class 2", r2)
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

describe("Methods should work", function()
   MyClass = newclass(function (self)
      self.n = 10
   end)
   function MyClass:return_double_and_add(a)
      result = self.n * 2
      self.n = self.n + a
      return result
   end
   
   sut = MyClass:new()
   
   ret = sut.return_double_and_add(5)
   assert.are.equal(20, ret);
   assert.are.equal(15, sut.n);
   
   ret = sut.return_double_and_add(2)
   assert.are.equal(30, ret);
   assert.are.equal(17, sut.n);
end)
