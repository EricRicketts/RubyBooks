require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class LambdaTest < Minitest::Test
  attr_accessor :add_two_proc, :add_two_v1, :add_two_v2

  def setup
    @add_two_proc = Proc.new { |x, y| x + y }
    @add_two_v1 = lambda { |x, y| x + y }
    @add_two_v2 = ->(x, y){ x + y }
  end

  def test_proc_and_lambda_class
    assert_equal([Proc, Proc], [add_two_proc.class, add_two_v1.class])
  end

  def test_for_lambda_instance
    assert_equal([false, true], [add_two_proc.lambda?, add_two_v2.lambda?])
  end
end
