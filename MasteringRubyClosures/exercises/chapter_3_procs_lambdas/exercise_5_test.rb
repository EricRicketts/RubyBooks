require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class Exercise5Test < Minitest::Test
  attr_accessor :join_1, :join_2

  def setup
    @join_1 = Proc.new { |x, y, z| "#{x}, #{y}, #{z}" }
    @join_2 = ->(x, y, z){ "#{x}, #{y}, #{z}" }
  end

  def test_join_1_missing_parameter
    assert_equal("Hello, World, ", join_1.call("Hello", "World"))
  end

  def test_join_2_missing_parameter
    assert_raises(ArgumentError) { join_2.call("Hello", "World") }
  end
end
