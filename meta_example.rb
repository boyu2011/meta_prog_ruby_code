
=begin

#
# Chapter 1
#

10.times do
  class C
    puts 'hello'
  end
end

# In a sense, the class keyword in Ruby is more like a scope operator than a class declaration.

class D
  def x; puts 'x'; end
end

class D
  def y; puts 'y'; end
end

obj = D.new
obj.x
obj.y

#

array = [ 'a', 'b', 'c' ]
array.each_with_index do |e, i|
  array[i] = 'e' if e == 'c'
end
puts array

#

class MyClass
  def my_method
    @v = 1
  end
end

# Instance variables live in objects, and methods live in classes.
# Objects that share the same class also share the same methods, so the methods must be stored in the class, not the object.

obj = MyClass.new
puts 'before called my_method'
puts obj.instance_variables
obj.my_method
puts 'after called my_method'
puts obj.instance_variables

puts obj.methods.grep /^m/
puts obj

puts String.methods
puts String.instance_methods 

puts String.instance_methods == "abc".methods

puts String.methods == "abc".methods

puts "hello".class
puts String.class

puts Class.methods

inherited = false
puts Class.instance_methods inherited

puts String.superclass
puts Object.superclass

puts Class.superclass
puts Module.superclass

class MyClass; end

MyClass.superclass

module M
  class C
    X = "a constant"
  end
  
  puts C::X
end

module M
  Y = "another constant"
  
  class C
    puts ::M::Y
  end
end

puts M.constants

puts Module.constants[0..1]

module M
  class C
    module M2
      puts Module.nesting   # current path
    end
  end
end

require 'hello.rb'

puts MyClass.ancestors

module M
  def my_method
    'M#my_method()'
  end
end

class C
  include M
end

class D < C; end

puts D.new.my_method

puts D.ancestors

puts Kernel.methods.grep /^pr/

# 

module Print_With_Black
  def print
    'print with Black ink'
  end
end

module Print_With_Color
  def print
    'print with color ink'
  end
end

class Book
  #include Print_With_Black
  include Print_With_Color
  include Print_With_Black
end

book = Book.new
puts book.print

#puts book.methods
puts Book.instance_methods


1.7 Object Model Wrap-Up
Here’s a checklist of what you learned today:
• An object is composed of a bunch of instance variables and a link to a class.
• The methods of an object live in the object’s class (from the point of view of the class, they’re called instance methods).
• The class itself is just an object of class Class. The name of the class is just a constant.
• Class is a subclass of Module. A module is basically a package of methods. In addition to that, a class can also be instantiated (with new( )) or arranged in a hierarchy (through its superclass( )).
• Constants are arranged in a tree similar to a file system, where the names of modules and classes play the part of directories and regular constants play the part of files.
• Each class has an ancestors chain, beginning with the class itself and going up to BasicObject.
• When you call a method, Ruby goes right into the class of the receiver and then up the ancestors chain, until it either finds the method or reaches the end of the chain.
• Every time a class includes a module, the module is inserted in the ancestors chain right above the class itself.
• When you call a method, the receiver takes the role of self.
• When you’re defining a module (or a class), the module takes the
role of self.
• Instance variables are always assumed to be instance variables of
self.
• Any method called without an explicit receiver is assumed to be a
method of self.
Checked. . . checked. . . done! Now it’s time to go home before your brain explodes with all the information you crammed into it today.

=end


#
# Chapter 2 : Methods
#

#
# Dynamic Method Example
#

class DataSource
  def initialize
  end
  
  def get_mouse_info(computer_id)
    return "SHUANGFEIYAN" if computer_id == 1
    return "MICROSOFT" if computer_id == 2
  end
  
  def get_mouse_price(computer_id)
    return 10 if computer_id == 1
    return 20 if computer_id == 2
  end
  
  def get_cpu_info(computer_id)
    return "INTEL DURE CORE 2.5" if computer_id == 1
    return "AMD 2.3" if computer_id == 2
  end
  
  def get_cpu_price(computer_id)
    return 200 if computer_id == 1
    return 100 if computer_id == 2
  end
end


class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
    # With this sentence, if someone adds a new component to DS, the Computer class will support it automatically.
    data_source.methods.grep( /^get_(.*)_info$/ ) { Computer.define_component $1 }
  end
  
  def self.define_component(name)
    define_method(name) {
      info = @data_source.send "get_#{name}_info", @id
      price = @data_source.send "get_#{name}_price", @id
      result = "#{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    }
  end
end

my_computer = Computer.new(1, DataSource.new)
puts my_computer.cpu
puts my_computer.methods







