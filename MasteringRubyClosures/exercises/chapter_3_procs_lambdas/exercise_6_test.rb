require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class Exercise6Test < Minitest::Test
  attr_accessor :join_1, :join_2

  def setup
    @join_1 = Proc.new { |x, y, z| x + y + z }
    @join_2 = lambda { |x, y, z| x + y + z }
  end

  def test_join_1_missing_argument
    assert_raises(TypeError) { join_1.call(1, 2)}
  end

  def test_join_2_missing_argument
    assert_raises(ArgumentError) { join_2.call(1, 2) }
  end
end
