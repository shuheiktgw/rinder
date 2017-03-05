class Photo

  PROPERTIES = %w(id url processedFiles).freeze
  PROPERTIES.map(&:to_sym).each { |p| attr_accessor p }

  def initialize(data)
    define_properties(data)
  end

  def define_properties(data)
    PROPERTIES.each do |p|
      eval "@#{p} = data[#{':' + p}]"
    end
  end

  def ==(other)
    return false unless self.class == other.class
    return true if PROPERTIES.all? { |p| eval "self.#{p} == other.#{p}" }
    false
  end
end
