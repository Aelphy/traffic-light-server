#coding: utf-8
class TrafficLightMode
  @@mode = 'Стандартный'

  def self.get
    @@mode
  end

  def self.set(mode)
    @@mode = mode
  end
end
