require_relative './data_source'

class ComputerFirstRefactor
  attr_reader :id, :data_source

  def initialize(id, data_source)
    @id = id
    @data_source = data_source
  end

  def mouse
    info = data_source.get_mouse_info(id)
    price = data_source.get_mouse_price(id)
    result = "Mouse: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def cpu
    info = data_source.get_cpu_info(id)
    price = data_source.get_cpu_price(id)
    result = "CPU: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def keyboard
    info = data_source.get_keyboard_info(id)
    price = data_source.get_keyboard_price(id)
    result = "Keyboard: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end
