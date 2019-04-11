require 'minitest/autorun'
require 'minitest/pride'
require 'pry-byebug'
require_relative '../lib/computer_first_refactor'

class ComputerFirstRefactorTest < Minitest::Test
  attr_reader :computer

  def setup
    @computer = ComputerFirstRefactor.new(42, DataSource.new)
  end

  def test_mouse
    expected = 'Mouse: Wireless Touch ($60)'
    assert_equal(expected, computer.mouse)
  end

  def test_cpu
    expected = '* CPU: 2.9Ghz Quad Core ($180)'
    assert_equal(expected, computer.cpu)
  end

  def test_keyboard
    expected = 'Keyboard: USB Keyboard ($20)'
    assert_equal(expected, computer.keyboard)
  end
end
