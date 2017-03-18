require_relative '../../../lib/rinder/profile/user_profile'

class Response
  attr_reader :faraday_response

  def self.initialize_recommendations(res)
    instance = self.new(res)
    recs = Array(res.body[:results]).map { |r| UserProfile.new(r) }

    instance.instance_variable_set(:@recommendations, recs)
    def instance.recommendations
      @recommendations
    end

    instance
  end

  def initialize(res)
    @faraday_response = res
  end

  def method_missing(method, *args)
    faraday_response.send(method, *args)
  end

  def respond_to_missing?(method, include_private = false)
    faraday_response.respond_to?(method)
  end
end
