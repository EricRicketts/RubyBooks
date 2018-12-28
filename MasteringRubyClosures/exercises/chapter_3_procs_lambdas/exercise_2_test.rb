require 'minitest/autorun'
require 'minitest/reporters'
require 'pry-byebug'
Minitest::Reporters.use!

class SpiceGirl

  def self.to_proc
    Proc.new do |name, nick|
      SpiceGirl.new(name, nick).inspect
    end
  end

  def initialize(name, nick)
    @name = name
    @nick = nick
  end

  def inspect
    "#{@name} (#{@nick} Spice)"
  end

end

class Exercise2Test < Minitest::Test
  attr_accessor :spice_girls

  def setup
    @spice_girls = [
      ["Mel B", "Scary"], ["Mel C", "Sporty"],
      ["Emma B", "Baby"], ["Geri H", "Ginger"],
      ["Vic B", "Posh"]
    ]
  end

  def test_spice_girls
    expected = [
      "Mel B (Scary Spice)", "Mel C (Sporty Spice)",
      "Emma B (Baby Spice)", "Geri H (Ginger Spice)",
      "Vic B (Posh Spice)"
    ]
    result = spice_girls.map(&SpiceGirl)
    assert_equal(expected, result)
  end
end
