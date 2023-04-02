# require 'rspec/autorun'

def split(word)
  [word[0..6], word[7..-1]]
end

def row_number(word)
  word.gsub('B', '1').gsub('F', '0').to_i(2)
end

def column_number(word)
  word.gsub('R', '1').gsub('L', '0').to_i(2)
end

def place(word)
  row, column = split(word)
  row_number(row) * 8 + column_number(column)
end

# RSpec.describe '#column_number' do
#   it 'converts row word into number' do
#     expect(column_number('RRR')).to eq(7)
#   end
# end


# RSpec.describe '#row_number' do
#   it 'converts row word into number' do
#     expect(row_number('BFFFBBF')).to eq(70)
#   end
# end

# RSpec.describe '#split' do
#   it 'splits word in descriptions for row and column' do
#     expect(split('BFFFBBFRRR')).to eq(%w[BFFFBBF RRR])
#   end
# end

# RSpec.describe '#place' do
#   it 'converts word to place number' do
#     expect(place('BFFFBBFRRR')).to eq(567)
#     expect(place('FFFBBBFRRR')).to eq(119)
#     expect(place('BBFFBBFRLL')).to eq(820)
#   end
# end

passes = File.read('input.txt').split

passes.map! { |pass| place(pass) }.sort!

(1..passes.length - 1).each do |index|
  if passes[index] - passes[index-1] > 1
    p passes[index] - 1
  end
end
