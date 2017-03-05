require 'date'

class Profile

  PROPERTIES = %w(distance_mi common_like_count common_friend_count common_likes common_friends _id name birth_date birth_date_info gender bio ping_time photos).freeze
  PROPERTIES.map(&:to_sym).each { |p| attr_accessor p }

  def initialize(data)
    define_properties(data)
  end

  def define_properties(data)
    PROPERTIES.each do |p|
      if p == 'photos'
        @photos = define_photos_property(data)
      elsif p == 'birth_date' || p == 'ping_time'
        eval "@#{p} = DateTime.parse(data[#{':' + p}])"
      else
        eval "@#{p} = data[#{':' + p}]"
      end
    end
  end

  def define_photos_property(data)
    Array(data['photos']).map { |p| Photo.new(p) }
  end
end
