require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'
require_relative '../lib/computer_missing_method'

class ComputerMissingMethodTest < Minitest::Test
  attr_reader :computer

  def setup
    @computer = ComputerMissingMethod.new(42, DataSource.new)
  end

  def test_mouse
    # skip
    expected = 'Mouse: Wireless Touch ($60)'
    assert_equal(expected, computer.mouse)
  end

  def test_cpu
    # skip
    expected = '* Cpu: 2.9Ghz Quad Core ($180)'
    assert_equal(expected, computer.cpu)
  end

  def test_keyboard
    # skip
    expected = 'Keyboard: USB Keyboard ($20)'
    assert_equal(expected, computer.keyboard)
  end

  def test_respond_to_ghost_methods
    # skip
    [:mouse, :cpu, :keyboard].each do |method|
      computer.respond_to?(method)
    end
  end
end
