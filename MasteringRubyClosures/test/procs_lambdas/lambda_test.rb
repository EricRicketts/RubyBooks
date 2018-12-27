require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class LambdaTest < Minitest::Test
  attr_accessor :add_two_proc, :add_two_v1, :add_two_v2, :key_value_proc,
    :key_value_lambda

  def setup
    @add_two_proc = Proc.new { |x, y| x + y }
    @add_two_v1 = lambda { |x, y| x + y }
    @add_two_v2 = ->(x, y){ x + y }
    @key_value_proc = Proc.new { |x, y| "x: #{x}, y: #{y}" }
    @key_value_lambda = ->(x, y){ "x: #{x}, y: #{y}" }
  end

  def test_proc_and_lambda_class
    assert_equal([Proc, Proc], [add_two_proc.class, add_two_v1.class])
  end

  def test_for_lambda_instance
    assert_equal([false, true], [add_two_proc.lambda?, add_two_v2.lambda?])
  end

  def test_proc_one_less_argument
    assert_equal("x: 1, y: ", key_value_proc.call(1))
  end

  def test_proc_one_more_argument
    assert_equal("x: 1, y: 2", key_value_proc.call(1, 2))
  end

  def test_lambda_one_less_argument
    assert_raises(ArgumentError) { key_value_lambda.call(1) }
  end

  def test_lambda_one_more_argument
    assert_raises(ArgumentError) { key_value_lambda.call(1, 2, 3) }
  end
end
