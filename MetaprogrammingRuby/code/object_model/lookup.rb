#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyClass
  def my_method; 'my_method()'; end
end

class MySubclass < MyClass
end

obj = MySubclass.new
obj.my_method()       # => "my_method()"

MySubclass.ancestors # => [MySubclass, MyClass, Object, Kernel, BasicObject]

require_relative '../test/assertions'
assert_equals [MySubclass, MyClass, Object, Kernel, BasicObject], MySubclass.ancestors
