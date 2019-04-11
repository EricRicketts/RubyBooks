require_relative './data_source'

class ComputerDynamicDispatch
  attr_reader :id, :data_source

  def initialize(id, data_source)
    @id = id
    @data_source = data_source
  end

  def mouse
    component(:mouse)
  end

  def cpu
    component(:cpu)
  end

  def keyboard
    component(:keyboard)
  end

  def component(name)
    info = data_source.send("get_#{name}_info", id)
    price = data_source.send("get_#{name}_price", id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end
