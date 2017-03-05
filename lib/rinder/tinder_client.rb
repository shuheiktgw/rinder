require 'TinderHTTP/request'

class TinderClient

  attr_reader :token

  def initialize(email, password)
    @email = email
    @password = password
    @request = Request.new(email, password)
  end

  def get_token(email, password)



    # Store user infos in instance vars?

  end

  def get_recommendation


  end

  def initialize_request(email, password)
    request, attrs = Request.new(email, password)
  end
end
