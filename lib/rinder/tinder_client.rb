require 'TinderHTTP/request'

class TinderClient

  attr_reader :email, :password, :request

  def initialize(email, password)
    @email = email
    @password = password
    @request = initialize_request(email, password)
  end

  def get_recommendation
    request.recommendations
  end

  def like(user)
    request.like(user)
  end

  def initialize_request(email, password)
    Request.factory(email, password)
  end
end
