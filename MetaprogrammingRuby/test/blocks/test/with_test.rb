require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'
require_relative '../lib/with'

class WithTest < Minitest::Test
  class Resource
    def dispose
      @disposed = true
    end

    def disposed?
      @disposed
    end
  end

  def test_disposes_of_resources
    # skip
    r = Resource.new
    with(r) {}
    assert r.disposed?
  end

  def test_disposes_of_resources_in_case_of_exception
    # skip
    r = Resource.new
    assert_raises(Exception) do
      with(r) { raise Exception }
    end
    assert r.disposed?
  end
end
