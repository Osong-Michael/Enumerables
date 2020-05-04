#:nodoc:
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    size.times { |index| yield(to_a[index]) }
    self
  end

  def my_each_with_index
    return to_enum :my_each unless block_given?

    size.times { |index| yield(to_a[index], index) }
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

  def my_none?(val = nil, &block)
    !my_any?(val, &block)
  end

  def my_count(parameter = nil)
    count = 0

    if block_given?
      my_each { |index| count += 1 if yield(index) }
    elsif parameter
      my_each { |index| count += 1 if index == parameter }
    else
      count = size
    end
    count
  end

  def my_map(proc = nil)
    return to_enum :my_map unless block_given?

    mapped = []
    my_each { |index| mapped << (proc ? proc.call(index) : yield(index)) }
    mapped
  end

  def my_inject(*val)
    array = is_a?(Array) ? self : to_a
    new_array = val[0] if val[0].is_a? Integer

    if val[0].is_a?(Symbol) || val[0].is_a?(String)
      sym = val[0]
    elsif val[0].is_a?(Integer)
      sym = val[1] if val[1].is_a?(Symbol) || val[1].is_a?(String)
    end

    if sym
      array.my_each { |index| new_array = new_array ? new_array.send(sym, index) : index }
    else
      array.my_each { |index| new_array = new_array ? yield(new_array, index) : index }
    end

    new_array
  end
end
