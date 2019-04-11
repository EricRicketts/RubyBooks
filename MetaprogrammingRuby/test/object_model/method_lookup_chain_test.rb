require "minitest/autorun"
require "minitest/reporters"
require "pry-byebug"
Minitest::Reporters.use!

module M1
end

module M2
  include M1
end

module M3
  prepend M1
  include M2
end

class MethodLookupChainTest < Minitest::Test

  def test_module_lookup_chain
    assert_equal([M1, M3, M2], M3.ancestors)
  end
end