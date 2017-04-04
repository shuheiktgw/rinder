require 'TinderHTTP/request'

class TinderClient

  attr_reader :request

  def initialize(email, password)
    @request = init_request(email, password)
  end

  def get_recommendations
    request.recommendations
  end

  def like(recommendations, interval_sec = 0.5)
    request.like(recommendations, interval_sec)
  end

  private

  def init_request(email, password)
    TinderHTTP::Request.new(email, password)
  end
end
