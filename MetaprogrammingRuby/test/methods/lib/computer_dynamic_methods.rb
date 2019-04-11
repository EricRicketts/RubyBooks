require_relative './data_source.rb'

class ComputerDynamicMethods
  attr_reader :id, :data_source

  def initialize(id, data_source)
    @id = id
    @data_source = data_source
  end

  def self.define_component(name)
    define_method(name) do
      info = data_source.send("get_#{name}_info", id)
      price = data_source.send("get_#{name}_price", id)
      result = "#{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end

  [:mouse, :cpu, :keyboard].each { |name| define_component(name)}
end
