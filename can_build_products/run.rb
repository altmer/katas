require 'rspec/autorun'

def tally(str)
  acc = {}
  index = 0
  while index < str.length do
    ch = str[index]
    acc[ch] ||= 0
    acc[ch] += 1
    index += 1
  end
  acc
end

def can_build?(parts_tally, product)
  product_tally = tally(product)
  can_build = true
  product_tally.each do |part, count|
    can_build &&= (parts_tally[part].to_i >= count)
  end
  can_build
end

def buildable_count(parts, products)
  return 0 if parts.nil? || parts.empty?
  return 0 if products.nil? || products.empty?

  parts_tally = tally(parts)
  acc = 0

  products.each do |product|
    acc += 1 if can_build?(parts_tally, product)
  end
  acc
end

RSpec.describe '#buildable_count' do
  let(:parts) { 'aaabbaaccccdddaee' }
  let(:products) do
    [
      'aabbbaacde',
      'aaaaaabccce',
      'eee',
      'dddccccaaaaaaeebb',
      't'
    ]
  end

  it 'correctly counts how many products can we build' do
    expect(buildable_count(parts, products)).to eq(2)
  end
end

RSpec.describe '#can_build?' do
  let(:parts) { 'aaabbaaccccdddaee' }
  let(:product) { 'aabbbaacde' }

  let(:parts_tally) { tally(parts) }

  it 'returns false' do
    expect(can_build?(parts_tally, product)).to eq(false)
  end
end

RSpec.describe '#tally' do
  let(:parts) { 'aaabbaaccccdddaee' }
  let(:product) { 'aabbbaacde' }

  it 'returns correct tally' do
    expect(tally(parts)).to eq({ 'a' => 6, 'b' => 2, 'c' => 4, 'd' => 3, 'e' => 2 })
    expect(tally(product)).to eq({ 'a' => 4, 'b' => 3, 'c' => 1, 'd' => 1, 'e' => 1 })
  end
end


