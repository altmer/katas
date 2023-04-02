def chop(num, arr)
  l = 0
  r = arr.length - 1
  while l <= r
    mid = (l + r) / 2
    value = arr[mid]
    if value == num
      return mid
    elsif value < num
      l = mid + 1
    else
      r = mid -1
    end
  end
  return -1
end
