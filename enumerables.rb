


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

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
# a.my_all? { |num| num > 1 } # => false
# a.my_all? { |num| num < 4 } # => true