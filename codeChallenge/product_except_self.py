def product_except_self(nums):
  """
  Given an array of integers, return a new array such that each element at index i
  of the new array is the product of all the numbers in the original array except
  the one at i.

  Examples:
  If the input was [1, 2, 3, 4, 5], the expected output would be [120, 60, 40, 30, 24].
  If the input was [3, 2, 1], the expected output would be [2, 3, 6].
  """

  n = len(nums)

  if n == 0:
    return []
  if n == 1:
    return [1] 

  result = [1] * n
  left_product = 1
  for i in range(n):
    result[i] = left_product
    left_product *= nums[i]

  right_product = 1
  for i in range(n - 1, -1, -1):
    result[i] *= right_product
    right_product *= nums[i]

  return result


# Examples:
input1 = [1, 2, 3, 4, 5]
output1 = product_except_self(input1)
print(f"Input: {input1}, Output: {output1}")

input2 = [3, 2, 1]
output2 = product_except_self(input2)
print(f"Input: {input2}, Output: {output2}")

input3 = [1, 2, 0, 4, 0]
output3 = product_except_self(input3)
print(f"Input: {input3}, Output: {output3}")
