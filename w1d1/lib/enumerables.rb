class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    results = []
    self.my_each do |elem|
      results << elem if prc.call(elem)
    end
    results
  end

  def my_reject(&prc)
    self - self.my_select(&prc)
  end

  def my_any?(&prc)
    self.my_each do |elem|
      return true if prc.call(elem)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |elem|
      return false if !prc.call(elem)
    end
    true
  end

  def my_flatten
    flat_array = []
    self.each do |elem|
      elem.is_a?(Array) ? flat_array += elem.my_flatten : flat_array << elem
    end
    flat_array
  end

  def my_zip(*args)
    results = Array.new(self.length){Array.new}
    self.length.times do |i|
      # results << []
      results[i] << self[i]
      args.each do |elem|
        results[i] << elem[i]
      end
    end
    results
  end

  def my_rotate(rot = 1)
    rot = rot % self.length
    self.drop(rot) + self.take(rot)
  end

  def my_join(sep = "")
    results = ""
    self.each_with_index do |elem, i|
      results += elem
      results += sep unless i == self.length - 1
    end
    results
  end

  def my_reverse
    reversed = []
    (self.length - 1).downto(0) do |i|
      reversed << self[i]
    end
    reversed
  end
end
