require 'rspec/autorun'

class Checkout
  def initialize
    @rules = [
      {
        name: 'apple',
        price: 300,
        rule: 'discountwhenx',
        values: { count: 2, discount: 0.8 }
      },
      {
        name: 'peach',
        price: 700,
        rule: 'nodiscount',
        values: {}
      },
      {
        name: 'grape',
        price: 500,
        rule: 'xfory',
        values: { count: 2, price: 500 }
      }
    ]
  end

  def price(products)
    products.reduce(0) do |acc, product|
      product_name, count = product
      rule = find_rule(product_name)
      raise "No rule found for #{product_name}" if rule.nil?
      acc + calculate(rule, count)
    end
  end

  private

  def find_rule(product_name)
    @rules.find { |rule| rule[:name] == product_name }
  end

  def calculate(rule, count)
    values = rule[:values]
    price = rule[:price]

    case rule[:rule]
    when 'discountwhenx'
      if count >= values[:count]
        price * count * values[:discount]
      else
        price * count
      end
    when 'xfory'
      ((count / values[:count]) * price) + ((count % values[:count]) * price)
    else
      price * count
    end
  end
end


RSpec.describe Checkout do
  subject { Checkout.new }

  it 'calculates prices' do
    expect(subject.price([['apple', 1], ['peach', 1], ['grape', 1]])).to eq(1500)
    expect(subject.price([['apple', 1], ['peach', 1], ['grape', 2]])).to eq(1500)
    expect(subject.price([['apple', 1], ['peach', 1], ['grape', 3]])).to eq(2000)
    expect(subject.price([['apple', 1], ['peach', 1], ['grape', 4]])).to eq(2000)
    expect(subject.price([['apple', 2], ['peach', 1], ['grape', 4]])).to eq(2180)
    expect(subject.price([['apple', 3], ['peach', 1], ['grape', 4]])).to eq(2420)
    expect(subject.price([['apple', 3], ['peach', 2], ['grape', 4]])).to eq(3120)
  end
end
