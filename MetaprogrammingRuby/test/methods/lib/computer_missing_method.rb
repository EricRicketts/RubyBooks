require_relative './data_source'

class ComputerMissingMethod
  attr_reader :id, :data_source

  def initialize(id, data_source)
    @id = id
    @data_source = data_source
  end

  def method_missing(name)
    super unless data_source.respond_to?("get_#{name}_info")
    info = data_source.send("get_#{name}_info", id)
    price = data_source.send("get_#{name}_price", id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end
