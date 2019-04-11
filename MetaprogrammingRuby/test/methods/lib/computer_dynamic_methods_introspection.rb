require_relative './data_source'

class ComputerDynamicMethodsIntrospection
  attr_reader :id, :data_source

  def initialize(id, data_source)
    @id = id
    @data_source = data_source
    @data_source.public_methods(false).grep(/^get_(.*)_info$/) do
      self.class.define_component($1)
    end
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
end
