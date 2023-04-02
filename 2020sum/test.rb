# frozen_string_literal: true

require_relative './sum2020.rb'
require 'test-unit'

class TestPrice < Test::Unit::TestCase
  def test_sum
    nums = [1721, 979, 366, 299, 675, 1456]
    assert_equal(
      514579,
      sum2020(nums)
    )
  end

  def test_bsearch
    nums = [1721, 979, 366, 299, 675, 1456].sort
    assert_equal(
      0,
      bsearch(nums, 299)
    )
    assert_equal(
      5,
      bsearch(nums, 1721)
    )
  end
end
