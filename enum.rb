#:nodoc:
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    length.times { |index| yield(self[index]) }
    self
  end

  def my_each_with_index
    return to_enum :my_each unless block_given?

    length.times { |index| yield(self[index], index) }
    self
  end

  def my_select
    return to_enum :my_select unless block_given?

    array = []
    my_each { |index| array << index if yield(index) }
    array
  end

  def my_all?(*val)
    new_array = true
    if !val[0].nil?
      my_each { |index| new_array = false unless val[0] === index }
    elsif !block_given?
      my_each { |index| new_array = false unless index }
    else
      my_each { |index| new_array = false unless yield(index) }
    end
    new_array
  end

  def my_any?(*val)
    new_array = false
    if !val[0].nil?
      my_each { |index| new_array = true if val[0] === index }
    elsif !block_given?
      my_each { |index| new_array = true if index }
    else
      my_each { |index| new_array = true if yield(index) }
    end
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
    return to_enum :my_map unless block_given?

    mapped = []
    my_each { |index| mapped << (proc.nil? ? proc.call(index) : yield(index)) }
    mapped
  end

  def my_inject(total = 0)
    my_each { |index| total = yield(total, index) }
    total
  end
end
