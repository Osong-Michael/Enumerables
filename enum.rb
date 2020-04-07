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
end