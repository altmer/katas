require 'rspec/autorun'

class Node
  attr_accessor :value, :key, :next_node, :prev_node

  def initialize(value:, key:, next_node:, prev_node:)
    @value = value
    @key = key
    @next_node = next_node
    @prev_node = prev_node
  end
end

class LRU
  def initialize(capacity)
    @capacity = capacity
    @lookup_table = {}
    @head = nil
    @tail = nil
    @items_count = 0
  end

  def set(key, value)
    @items_count += 1

    if @items_count > @capacity
      @lookup_table.delete(@head.key)
      @items_count = @capacity
      @head = @head.next_node
    end

    new_node = Node.new(value: value, next_node: nil, prev_node: @tail, key: key)
    if @tail.nil?
      @head = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
    @lookup_table[key] = new_node
  end

  def get(key)
    res = @lookup_table[key]
    return nil if res.nil?
    return res.value if res == @tail

    if res == @head
      @head = res.next_node
      @head.prev_node = nil
    else
      res.prev_node.next_node = res.next_node
    end

    @tail.next_node = res
    res.next_node = nil
    res.prev_node = @tail
    @tail = res

    res.value
  end
end

RSpec.describe LRU do
  subject { LRU.new(5) }
  it 'sets and gets values' do
    subject.set('a', 1)
    expect(subject.get('a')).to eq(1)
  end

  context 'maxed out capacity' do
    before do
      (1..5).each do |ind|
        subject.set(ind, ind.to_s)
        subject.get(ind)
      end
    end

    it 'replaces the least recently used' do
      subject.set(10, '10')
      expect(subject.get(10)).to eq('10')
      expect(subject.get(1)).to eq(nil)
    end
  end
end

