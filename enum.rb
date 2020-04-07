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
end