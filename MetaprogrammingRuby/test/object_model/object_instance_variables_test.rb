require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class ObjectInstanceVariablesTest < Minitest::Test
  attr_accessor :obj1, :obj2

  class MyClass
    def my_method
      @v = 1
    end
  end

  def setup
    @obj1 = MyClass.new
    @obj2 = MyClass.new
  end

  def test_no_instance_variables
    assert_empty(obj1.instance_variables)
  end

  def test_instance_variable_creation
    obj2.my_method
    assert_equal([:@v], obj2.instance_variables)
  end

  def test_instance_methods_where_at
    assert(String.instance_methods == "abc".methods)
    refute(String.methods == "abc".methods)
  end

  def test_instance_variables_unique_to_objects
    obj1.my_method
    obj2.instance_variable_set("@u", 2)
    result = [obj1.instance_variables, obj2.instance_variables].flatten
    assert_equal([:@v, :@u], result)
  end
end
