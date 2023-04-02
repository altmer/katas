def bsearch(array, num)
  l = 0
  r = array.length - 1
  while l <= r do
    mid = (l + r) / 2
    if array[mid] == num
      return mid
    elsif array[mid] < num
      l = mid + 1
    else
      r = mid - 1
    end
  end
  -1
end

def sum2020(nums)
  sorted = nums.sort
  res = -1
  sorted.each do |num|
    addition = 2020 - num
    if bsearch(sorted, addition) != -1
      res = addition * num
      break
    end
  end
  res
end

def sum2020_3(nums)
  nums = nums.sort
  nums.each_with_index do |num, index|
    sum = 2020 - num
    return -1 if index + 1 >= nums.length

    (index + 1..nums.length - 1).each do |index2|
      num2 = nums[index2]
      sum2 = sum - num2

      num3 = nums.find { |n| n == sum2 }
      return num * num2 * num3 if num3
    end
  end
  return -1
end

# RSpec.describe 'sum2020' do
#   it 'finds multiplication of 3 numbers summing up to 2020' do
#     expect(sum2020([1721, 979, 366, 299, 675, 1456])).to eq(241861950)
#   end
# end

nums = File.read('input').split.map(&:to_i)
puts sum2020_3(nums)
