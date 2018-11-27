require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class LexicalScopingTest < Minitest::Test

  def test_one
    msg = "the principle's car."
    arr = []
    expected = Array.new(3, "I will not drive the principle's car.")
    3.times do
      prefix = "I will not drive"
      arr << "#{prefix} #{msg}"
    end
    assert_equal(expected, arr)
    assert_raises(NameError) { prefix }
  end
end

=begin
note the code block associated with #times can access the msg
local variable as it is initialized in a parent scope.

However, the reverse is not true, the prefix local variable within
the block cannot be accessed in the outer scope.
=end
