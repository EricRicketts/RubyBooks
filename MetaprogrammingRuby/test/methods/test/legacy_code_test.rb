require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'
require_relative '../lib/data_source'

class OriginalRefactorTest < Minitest::Test
  attr_reader :data_source

  def setup
    @data_source = DataSource.new
  end

  def test_cpu
    expected = ['2.9Ghz Quad Core', 180]
    results = [
      data_source.get_cpu_info(42),
      data_source.get_cpu_price(42)
    ]
    assert(expected, results)
  end
end
