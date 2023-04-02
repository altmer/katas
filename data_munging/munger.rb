class Munger
  def initialize(filename, columns, ignore_patterns)
    @filename = filename
    @columns = columns
    @ignore_patterns = ignore_patterns
  end

  def call
    current_diff = 1000000
    current_value = -1
    File.foreach(filename) do |line|
      next if line&.empty?
      data = line.strip.split
      next if data.empty?
      next if ignore_patterns.include?(data[0])
      diff = (data[columns[:left]].to_i - data[columns[:right]].to_i).abs

      if diff < current_diff
        current_diff = diff
        current_value = data[columns[:value]]
      end
    end
    current_value
  end

  private

  attr_accessor :filename, :columns, :ignore_patterns
end
