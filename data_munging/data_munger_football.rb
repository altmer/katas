class DataMungerFootball
  def initialize()
    @munger = Munger.new(
        'football.dat',
        { left: 6, right: 8, value: 1 },
        ['Team', '-------------------------------------------------------']
      )
  end

  def call
    @munger.call
  end
end
