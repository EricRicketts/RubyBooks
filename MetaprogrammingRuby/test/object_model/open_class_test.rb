require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!


class OpenClassTest < Minitest::Test
  class D
    def x
      'x'
    end
  end

  def test_initial_methods
    assert_equal([:x, :y], D.instance_methods(false))
  end

  class D
    def y
      'y'
    end
  end
end
