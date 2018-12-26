require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class FirstProcTests < Minitest::Test
  attr_accessor :add_proc, :even

  def setup
    @add_proc = Proc.new { |x, y| x + y }
    @even = Proc.new { |x| (x % 2).zero? }
  end

  def test_standard_call_method
    assert_equal(5, add_proc.call(2, 3))
  end

  def test_abbreviated_call_method
    assert_equal(5, add_proc.(2, 3))
  end

  def test_three_equals_operator
    result = case 10
    when even
      "it was an even number"
    else
      "it was an odd number"
    end
    assert_equal("it was an even number", result)
  end
end
