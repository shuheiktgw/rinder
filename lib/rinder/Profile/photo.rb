class Photo

  PROPERTIES = %w(id main crop fileName extension url processedFiles).freeze
  PROPERTIES.map(&:to_sym).each { |p| attr_accessor p }

  def initialize(data)
    define_properties(data)
  end

  def define_properties(data)
    PROPERTIES.each do |p|
      eval "@#{p} = data[#{':' + p}]"
    end
  end


end
