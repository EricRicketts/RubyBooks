require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'

class Exercise1Test < Minitest::Test

  def test_1
    # A closure is a block of code (a function) whose body
    # references a variable which is declared in a parent scope
    assert(true)
  end
end
