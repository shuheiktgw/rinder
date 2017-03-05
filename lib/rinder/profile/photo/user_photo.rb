require_relative 'photo'

class UserPhoto < Photo
  PROPERTIES = %w(id url processedFiles).freeze
  PROPERTIES.map(&:to_sym).each { |p| attr_accessor p }
end
