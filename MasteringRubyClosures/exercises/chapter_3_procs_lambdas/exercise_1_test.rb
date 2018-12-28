require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class Symbol
  def to_proc
    Proc.new { |obj, args| obj.send(self, *args) }
  end
end

class Exercise1Test < Minitest::Test
  attr_accessor :strs

  def setup
    @strs = %w[foo bar fizz buzz]
  end

  def test_no_args
    expected = %w[FOO BAR FIZZ BUZZ]
    result = strs.map(&:upcase)
    assert_equal(expected, result)
  end

  def test_with_args
    expected = "foobarfizzbuzz"
    result = strs.inject(&:+)
    assert_equal(expected, result)
  end
end
