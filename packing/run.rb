# As the owner of an online store, you need to fulfill orders everyday. To optimize the packing of each order, you decide to write an algorithm to match boxes and items based on their respective sizes.

# You have access to the following two boxes:

# - A medium box (identifier: M)

# - A large box (identifier: L)

# When possible, you should try to fit multiple items in the same box but boxes can only contain one type of product.

# This is the list of items you sell along with associated boxes:

# - Camera (identifier: Cam): one can fit in a medium box, and up to two can fit in a large box

# - Gaming Console (identifier: Game): too big for a medium box, but up to two can fit in a large box

# - max of 2 g consoles can fit in 1 box

# - Bluetooth speaker (identifier: Blue): one can fit in a large box . max is 1 per large box

# Your goal is to design a function that takes a list of items and returns the box & item matches (examples below).

# Your solution should work for any number of each item greater than or equal to zero.

# Input = [], Output = []

# ## Input/Output expectations

# ["Cam"] -> [M: ["Cam"]]

# ["Cam", "Game"] -> [M: ["Cam"], L: ["Game"]]

# ["Game", "Blue"] -> [L: ["Game"], L : ["Blue"]]

# ["Game", "Game", "Blue"] -> [L: ["Game", "Game"], L : ["Blue"]]

# ["Cam", "Cam", "Game", "Game"] -> [L: ["Cam", "Cam"], L: ["Game", "Game"]]

# ["Cam", "Cam", "Cam", "Game", "Game", "Game", "Cam", "Blue"] ->

# [L: ["Cam", "Cam"], L: ["Cam", "Cam"], L: ["Game", "Game"], L: ["Game"], L: ["Blue"]]

# ["Cam", "Cam", "Cam", "Game", "Game", "Cam", "Cam", "Blue", "Blue"] -> [L: ["Cam", "Cam"] , L: ["Cam", "Cam"] , M: ["Cam"] , L: ["Game", "Game"] , L: ["Blue"] , L: ["Blue"]]


require 'rspec/autorun'

class PackingService
  def initialize(rules)
    @rules = rules
  end

  def call(products)
    tal = tally(products)
    tal.keys.flat_map do |product|
      rule = rules[product]
      raise "rule not found for #{product}" if rule.nil?
      pack(rule, count)
    end
  end

  def tally(array)
    array.reduce({}) do |acc, item|
      acc[item] ||= 0
      acc[item] += 1
      acc
    end
  end

  def pack(rule, count)
  end

  attr_reader :rules
end

RULES = {
  'Cam' => {
    'M' => 1,
    'L' => 2
  },
  'Game' => {
    'L' => 2
  },
  'Blue' => {
    'L' => 1
  }
}

RSpec.describe PackingService do
  subject { PackingService.new(RULES) }

  describe '#call' do
    it 'packs items' do
      expect(subject.call(%w[Cam]).sort).to eq([['M', %w[Cam]]] )
      expect(subject.call(%w[Cam Game]).sort).to eq([['M', %w[Cam]], ['L', %w[Game]]])
      expect(subject.call(%w[Game Blue]).sort).to eq([['L', %w[Blue]], ['L', %w[Game]]])
    end
  end

  describe '#tally' do
    it 'counts products' do
      expect(
        subject.tally(["Cam", "Cam", "Cam", "Game", "Game", "Cam", "Cam", "Blue", "Blue"])
      ).to eq({ 'Cam' => 5, 'Game' => 2, 'Blue' => 2 })
    end
  end
end
