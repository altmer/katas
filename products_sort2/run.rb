require 'rspec/autorun'

class ProductWrapper
  include Comparable

  def initialize(product)
    @product_s = product
    @product = product.split(',')
  end

  def price
    @price ||= @product[2].to_i
  end

  def popularity
    @popularity ||= @product[1].to_i
  end

  def <=>(other)
    return nil unless other.is_a?(ProductWrapper)
    if popularity == other.popularity
      price <=> other.price
    else
      other.popularity <=> popularity
    end
  end

  def to_s
    @product_s
  end
end

def sort_products(products)
  products
    .map { |product| ProductWrapper.new(product) }
    .sort
    .map(&:to_s)
end

RSpec.describe '#sort_products' do
  let(:products) do
    %w[A,87,12 B,93,11 C,87,11 D,,1 E,, F,99,]
  end

  it 'sorts products based on popularity and price' do
    expect(sort_products(products)).to eq(
      %w[F,99, B,93,11 C,87,11 A,87,12 E,, D,,1]
    )
  end
end

RSpec.describe ProductWrapper do
  subject { ProductWrapper.new(product) }
  let(:product) { 'A,87,12' }

  it 'returns correct price' do
    expect(subject.price).to eq(12)
  end

  it 'returns correct popularity' do
    expect(subject.popularity).to eq(87)
  end

  it 'compares products' do
    product_b = ProductWrapper.new('B,93,11')
    expect(product_b < subject).to eq(true)
  end
end

