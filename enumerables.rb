


# My Each

# Extend the Array class to include a method named my_each that
#  takes a block, calls the block on every element of the array,
#   and returns the original array. Do not use Enumerable's each
#    method. I want to be able to write:

class Array

    def my_each(&prc)
        i = 0
        while i < length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        new_arr = []
        my_each do |ele|
            new_arr << ele if prc.call(ele)
        end
        new_arr
    end

    def my_reject(&prc)
        new_arr = []
        my_each { |ele| new_arr << ele unless prc.call(ele) }
        new_arr
    end

    def my_any?(&prc)
        my_select { |ele| prc.call(ele) }.length > 0
    end

    def my_all?(&prc)
        my_select { |ele| prc.call(ele) }.length == length
    end

    def my_flatten
        
        arr = []

        my_each do |ele|
            if ele.is_a?(Array)
                arr += ele.my_flatten
            else
                arr << ele
            end
        end
        arr
    end

    def my_zip(*args)
        arr = []
        (0...length).each do |i|
            new_arr = []
            new_arr << self[i]
            args.each do |arg|
                new_arr << arg[i]
            end
            arr << new_arr
        end
        arr
    end

    def my_rotate(n=1)
        arr = self.clone
        if n.positive?
            n.times { arr.push(arr.shift) }
        else
            n *= -1 
            n.times { arr.unshift(arr.pop) } 
        end
        arr
    end


end


# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#     puts num
# end.my_each do |num|
#     puts num
# end
# # => 1
#     # 2
#     # 3
#     # 1
#     # 2
#     # 3

# p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# # p a.my_any? { |num| num > 1 } # => true
# # p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]