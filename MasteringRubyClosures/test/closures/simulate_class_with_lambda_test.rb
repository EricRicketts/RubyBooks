require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'
require_relative '../../code/closures/counter'
require_relative '../../code/closures/lambda_counter'

class SimulateClassWithLambdaTest < Minitest::Test
  attr_accessor :counter_class, :counter_lambda, :expected

  def setup
    @counter_class = CounterClass.new
    @counter_lambda = CounterLambda.call
    @expected = [0, 1, 2, 1, 0, 0]
  end

  def test_class
    results = [
      counter_class.get_x, counter_class.incr,
      counter_class.incr, counter_class.decr,
      counter_class.decr, counter_class.get_x
    ]
    assert_equal(expected, results)
  end

  def test_lambda
    results = [
      counter_lambda[:get_x].call, counter_lambda[:incr].call,
      counter_lambda[:incr].call, counter_lambda[:decr].call,
      counter_lambda[:decr].call, counter_lambda[:get_x].call,
    ]
    assert_equal(expected, results)
  end
end

=begin
Note in the initialization of @counter_lambda I had to call the
local variable CounterLambda because I need to execute the body
of the lambda to initialize the local variable x to zero.

And the return value is a hash where I can call the appropriate
lambdas to perform the desired operations.
=end
