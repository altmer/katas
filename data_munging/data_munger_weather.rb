class DataMungerWeather
  def initialize
    @munger = Munger.new('weather.dat', { left: 1, right: 2, value: 0 }, ['Dy', 'mo'])
  end

  def call
    @munger.call
  end
end

