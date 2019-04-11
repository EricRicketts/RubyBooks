class DataSource
  def get_mouse_info(id)
    id == 42 ? 'Wireless Touch' : 'Wireless Gamming'
  end

  def get_mouse_price(id)
    id == 42 ? 60 : 100
  end

  def get_cpu_info(id)
    id == 42 ? '2.9Ghz Quad Core' : '2.9Ghz Dual Core'
  end

  def get_cpu_price(id)
    id == 42 ? 180 : 90
  end

  def get_keyboard_info(id)
    id == 42 ? 'USB Keyboard' : 'Wireless Keyboard'
  end

  def get_keyboard_price(id)
    id == 42 ? 20 : 110
  end

end
