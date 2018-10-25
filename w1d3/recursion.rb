require 'byebug'
def recursive_range(start, finish)
  return [] if finish <= start
  return [start] + recursive_range(start+1, finish)
end

def iterative_range(start,finish)
  output = []
  i = start
  until i == finish
    output.push(i)
    i += 1
  end
  output
end

def recursion_one(b,n)
  return 1 if n == 0
  b * recursion_one(b, n - 1)
end

def recursion_two(b,n)
  return 1 if n == 0
  return b if n == 1
  if n.even?
    recursion_two(b, n/2) ** 2
  else
    b * (recursion_two(b, (n - 1)/2) ** 2)
  end
end

def deep_dup(array)
  output = []
  array.each do |el|
    if el.is_a?(Array)
      output.push(deep_dup(el))
    else
      output.push(el)
    end
  end
  output 
end

def iterative_fib(n)
  output = [0,1]
  until output.length == n 
    output.push(output[-1] + output[-2])
  end
  output 
end

def recursive_fib(n)
  return [0] if n == 1
  return [0,1] if n == 2
  # recursive_fib(n-1) + [recursive_fib(n-1).last + recursive_fib(n-2).last]
  recursive_fib(n-1) + [recursive_fib(n-1)[-2..-1].reduce(:+)]
end

def binary_search(array, value)
  return nil if array.empty?
  
  mid = (array.length-1) / 2
  return mid if array[mid] == value
  
  
  if value < array[mid]
    binary_search(array[0...mid], value)
  else
    temp = binary_search(array[mid+1..-1], value)
    return mid + 1 + temp if temp 
    nil 
  end 

end

def merge_sort(array)
  return array if array.length <= 1
  mid = array.length / 2
  left = array[0...mid]
  right = array[mid..-1] 
  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  return right if left.empty?
  return left if right.empty?
  if left[0] < right[0]
    [left[0]] + merge(left[1..-1], right)
  else
    [right[0]] + merge(left, right[1..-1])
  end 
end

def subsets(array)
  return [[]] if array.empty?
  output = []
  debugger
  prev_set = subsets(array[0...-1])
  prev_set.each do |arr|
    output << arr + [array.last] 
  end
  prev_set + output
end

def permutations(array)
  return [] if array.empty?
  return [array] if array.length == 1
  output = []
  prev_set = permutations(array[0...-1])
  prev_set.each do |arr|
    # debugger 
    array.length.times do |i|
      output << arr.take(i) + [array.last] + arr.drop(i) 
    end
  end
  output
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount <= 0
  chosen_coins = []
  until amount < coins[0]
    chosen_coins.push(coins[0])
    amount -= coins[0]
  end
  if amount > 0
    chosen_coins.concat(greedy_make_change( amount, coins = coins[1..-1]))
  end 
  chosen_coins
end

def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount <= 0
  return nil if coins.none? { |coin| coin <= amount }
  # an array of all possible combinations that sum to 24
  # select array of min length that is a possible combination 
  # how do we do this
  possibilities = []
  chosen_coins = []
  # debugger
  best_combo = nil
  coins.each_with_index do |coin, index|
    next if coin > amount
    # chosen_coins = []
    # chosen_coins << coin
    current_combo = [coin] + make_change(amount - coin, coins.drop(index))
    # possibilities << chosen_coins[0]
    if best_combo.nil? || best_combo.length > current_combo.length
      best_combo = current_combo
    end
  end 
  # chosen_coins
    # possibilities
  best_combo
   
  
end

p make_change(24, [10, 7, 1])