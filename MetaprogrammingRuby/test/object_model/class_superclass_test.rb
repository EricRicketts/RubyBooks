require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class ClassSuperclassTest < Minitest::Test
  attr_accessor :obj1

  class MyClass
    def my_method
      @v = 1
    end
  end

  def setup
    @obj1 = MyClass.new
  end

  def test_class_of_obj1
    assert_equal(MyClass, obj1.class)
  end

  def test_class_of_MyClass
    assert_equal([Class, Class], [MyClass.class, String.class])
  end

  def test_superclass_of_MyClass
    assert_equal(Object, MyClass.superclass)
  end

  def test_superclass_of_class
    assert_equal(Module, Class.superclass)
  end

  def test_class_of_module_and_class
    assert_equal([Class, Class], [Module.class, Class.class])
  end

  def test_super_class_of_module
    assert_equal(Object, Module.superclass)
  end
end