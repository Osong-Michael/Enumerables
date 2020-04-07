#:nodoc:
module Enumerable
  def my_each
    length.times { |index| yield(self[index]) }
    self
  end

  def my_each_with_index
    length.times { |index| yield(self[index], index) }
    self
  end

  def my_select
    array = []
    my_each { |index| array << index if yield(index) }
    array
  end

  def my_all?
    new_array = true
    my_each { |index| break new_array = false unless yield(index) }
    new_array
  end

  def my_any?
    new_array = false
    my_each { |index| break new_array = true if yield(index) }
    new_array
  end

  def my_none?
    new_array = true
    my_each { |index| break new_array = false if yield(index) }
    new_array
  end

  def my_count(parameter)
    count = 0
    my_each { |index| count += 1 if parameter == index }
    count
  end

  def my_map(proc)
    mapped = []
    my_each { |index| mapped << (proc.nil? ? proc.call(index) : yield(index)) }
    mapped
  end

  def my_inject(total = 0)
    my_each { |index| total = yield(total, index) }
    total
  end
end
