load 'new.rb'

include Enumerable

def multiply_els(array)
  array.my_inject(1) { |product, index| product * index }
end

my_proc = proc { |num| num * 2 }