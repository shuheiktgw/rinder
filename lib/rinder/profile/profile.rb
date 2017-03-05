class Profile

  def initialize(data)
    define_properties(data)
  end

  def define_properties(data)
    self.class::PROPERTIES.each do |p|
      if p == 'photos'
        @photos = define_photos_property(data)
      elsif date_property?(p)
        eval "@#{p} = DateTime.parse(data[#{':' + p}])"
      else
        eval "@#{p} = data[#{':' + p}]"
      end
    end
  end

  def date_property?(p)
    false
  end

  def define_photos_property(data)
    raise "You should override #define_photos_property in the #{self.class} class."
  end

  def ==(other)
    return false unless self.class == other.class
    return true if self.class::PROPERTIES.all? { |p| eval "self.#{p} == other.#{p}" }
    false
  end
end
