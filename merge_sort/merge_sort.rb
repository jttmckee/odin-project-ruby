def merge_sort(arr)
  if arr.size <= 1 then return arr[0..0] end

  arr1 = merge_sort(arr[0...(arr.size/2)])
  arr2 = merge_sort(arr[(arr.size/2)..-1])

  new_arr = []

  arr1.each do |element|
    while arr2.size > 0 && element > arr2[0]
      new_arr << arr2.shift
    end
    new_arr << element
  end
  new_arr += arr2
  return new_arr

end
