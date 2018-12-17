require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'
require '/Users/ericricketts/Documents/RubyBooks/MasteringRubyClosures/code/closures/reducer.rb'

class ReducerTest < Minitest::Test
  attr_accessor :reducer

  def setup
    @reducer = REDUCER
  end

  def test_reducer
    assert_equal(15, reducer.call(0, (1..5).to_a, lambda { |x, y| x + y }))
  end
end
