# require 'rspec/autorun'

def letters_tally(str)
  res = {}
  str.each_char do |ch|
    res[ch] ||= 0
    res[ch] += 1
  end
  res
end

def split_password(password)
  format = /(\d+)\-(\d+) ([a-z])\: ([a-z]+)/
  match = password.match(format)
  min, max, letter, pass = match.captures
  {
    min: min.to_i,
    max: max.to_i,
    letter: letter,
    password: pass
  }
end

def check_password(password)
  values = split_password(password)
  tally = letters_tally(values[:password])
  letter_count = tally[values[:letter]] || 0
  letter_count >= values[:min] && letter_count <= values[:max]
end

def check_password2(password)
  values = split_password(password)
  password = values[:password]
  letter = values[:letter]
  letter_l = password[values[:min] - 1]
  letter_r = password[values[:max] - 1]
  ((letter_l == letter) || (letter_r == letter)) && !((letter_l == letter) && (letter_r == letter))
end

# RSpec.describe '#check_password' do
#   it 'checks the validity of passwords' do
#     expect(check_password('1-3 a: abcde')).to eq(true)
#     expect(check_password('1-3 b: cdefg')).to eq(false)
#     expect(check_password('2-9 c: ccccccccc')).to eq(true)
#   end
# end

# RSpec.describe '#split_password' do
#   it 'returns hash with parsed rules and password' do
#     expect(split_password('1-3 a: abcde')).to eq(
#       { min: 1, max: 3, letter: 'a', password: 'abcde' }
#     )
#     expect(split_password('1-3 b: cdefg')).to eq(
#       { min: 1, max: 3, letter: 'b', password: 'cdefg' }
#     )

#     expect(split_password('2-9 c: ccccccccc')).to eq(
#       { min: 2, max: 9, letter: 'c', password: 'ccccccccc' }
#     )

#   end
# end

# RSpec.describe '#letters_tally' do
#   it 'returns hash with parsed rules and password' do
#     expect(letters_tally('abcde')).to eq(
#       { 'a' => 1, 'b' => 1, 'c' => 1, 'd' => 1, 'e' => 1 }
#     )
#     expect(letters_tally('cdefg')).to eq(
#       { 'c' => 1, 'd' => 1, 'e' => 1, 'f' => 1, 'g' => 1 }
#     )
#     expect(letters_tally('ccccccccc')).to eq(
#       { 'c' => 9 }
#     )
#   end
# end

passwords = File.read('input').split("\n")
res = 0
passwords.each do |password|
  res += 1 if check_password2(password)
end

p res