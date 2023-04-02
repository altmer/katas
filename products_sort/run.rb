require 'rspec/autorun'

def sort_products(products)
  return [] if products.nil? || products.empty?

  products.sort do |left, right|
    if left[:reviews] == right[:reviews]
      left[:price].to_f - right[:price].to_f
    else
      right[:reviews].to_f - left[:reviews].to_f
    end
  end
end

RSpec.describe '#sort_products' do
  let(:products) do
    [
      { name: 'A', reviews: 3.5, price: 13.48 },
      { name: 'B', reviews: 3.9, price: 10.0 },
      { name: 'C', reviews: 3.5, price: 9.99 },
      { name: 'D', reviews: 4.2, price: 29.99 },
      { name: 'E', reviews: nil, price: nil }
    ]a
  end

  it 'sorts products by reviews score and price' do
    expect(sort_products(products)).to eq([
      { name: 'D', reviews: 4.2, price: 29.99 },
      { name: 'B', reviews: 3.9, price: 10.0 },
      { name: 'C', reviews: 3.5, price: 9.99 },
      { name: 'A', reviews: 3.5, price: 13.48 },
      { name: 'E', reviews: nil, price: nil }
    ])
  end
end

require 'rspec/autorun'

def sort_products(products)
  return [] if products.nil? || products.empty?

  products.sort do |left, right|
    if left[:reviews] == right[:reviews]
      left[:price].to_f - right[:price].to_f
    else
      right[:reviews].to_f - left[:reviews].to_f
    end
  end
end

RSpec.describe '#sort_products' do
  let(:products) do
    [
      { name: 'A', reviews: 3.5, price: 13.48 },
      { name: 'B', reviews: 3.9, price: 10.0 },
      { name: 'C', reviews: 3.5, price: 9.99 },
      { name: 'D', reviews: 4.2, price: 29.99 },
      { name: 'E', reviews: nil, price: nil }
    ]a
  end

  it 'sorts products by reviews score and price' do
    expect(sort_products(products)).to eq([
      { name: 'D', reviews: 4.2, price: 29.99 },
      { name: 'B', reviews: 3.9, price: 10.0 },
      { name: 'C', reviews: 3.5, price: 9.99 },
      { name: 'A', reviews: 3.5, price: 13.48 },
      { name: 'E', reviews: nil, price: nil }
    ])
  end
end

