require 'test-unit'
require './munger.rb'
require './data_munger_weather.rb'
require './data_munger_football.rb'

class TestPrice < Test::Unit::TestCase
  def test_weather_data
    assert_equal(
      '14',
      DataMungerWeather.new.call
    )
  end

  def test_football_data
    assert_equal(
      'Aston_Villa',
      DataMungerFootball.new.call
    )
  end
end