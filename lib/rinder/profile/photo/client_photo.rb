require_relative 'photo'

class ClientPhoto < Photo
  PROPERTIES = %w(fileName id url fbId extension processedFiles successRate selectRate).freeze
  PROPERTIES.map(&:to_sym).each { |p| attr_accessor p }
end
