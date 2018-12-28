require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class Exercise3Test < Minitest::Test
  attr_accessor :foo, :bar

  def setup
    @foo = ->(x) { x + 2 }
    @bar = Proc.new { |x| x + 2 }
  end

  def test_proc_or_lambda
    assert_equal([true, false], [foo.lambda?, bar.lambda?])
  end

  def test_proc_and_lambda_class
    assert_equal([Proc, Proc], [foo.class, bar.class])
  end
end
