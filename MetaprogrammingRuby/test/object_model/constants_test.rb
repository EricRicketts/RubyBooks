require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

Y = "top level constant"

module MyModule
  MY_CONSTANT = "outer constant"

  class MyClass
    MY_CONSTANT = "inner constant"
    def get_outer_constant
      MyModule::MY_CONSTANT
    end

    def get_top_level_constant
      ::Y
    end
  end
end

class ConstantsTest < Minitest::Test

  def test_outer_constant
    assert_equal("outer constant", MyModule::MY_CONSTANT)
  end

  def test_inner_constant
    assert_equal("inner constant", MyModule::MyClass::MY_CONSTANT)
  end

  def test_access_to_outer_constant
    assert_equal("outer constant", MyModule::MyClass.new.get_outer_constant)
  end

  def test_top_level_constant
    assert_equal("top level constant", MyModule::MyClass.new.get_top_level_constant)
  end
end
