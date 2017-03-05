class Photo
  def initialize(data)
    define_properties(data)
  end

  def define_properties(data)
    self.class::PROPERTIES.each do |p|
      eval "@#{p} = data[#{':' + p}]"
    end
  end

  def ==(other)
    return false unless self.class == other.class
    return true if self.class::PROPERTIES.all? { |p| eval "self.#{p} == other.#{p}" }
    false
  end
end
