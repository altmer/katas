# frozen_string_literal: true

require_relative './anagrams.rb'
require 'test-unit'

class TestPrice < Test::Unit::TestCase
  def test_anagrams
    words = %w[undress crepitus sunders septa peats unpolitic paste cuprites tepas tapes spate pictures punctilio piecrust pates a b c d e f g h i j k l m n o p]
    assert_equal(
      anagrams(words).sort,
      [
        %w[crepitus cuprites pictures piecrust],
        %w[paste pates peats septa spate tapes tepas],
        %w[punctilio unpolitic],
        %w[sunders undress]
      ]
    )
  end
end

words = File.read('words').split
an = anagrams(words)
an.each do |row|
  puts row.join(' ')
end
puts an.count