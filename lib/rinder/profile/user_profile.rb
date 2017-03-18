require 'date'
require_relative 'profile'
require_relative './photo/user_photo'

class UserProfile < Profile

  PROPERTIES = %w(distance_mi common_like_count common_friend_count common_likes common_friends connection_count badges _id name birth_date gender bio ping_time photos jobs schools teaser teasers s_number).freeze
  PROPERTIES.map(&:to_sym).each { |p| attr_accessor p }

  def date_property?(p)
    p == 'birth_date' || p == 'ping_time'
  end

  def define_photos_property(data)
    Array(data[:photos]).map { |p| UserPhoto.new(p) }
  end
end
