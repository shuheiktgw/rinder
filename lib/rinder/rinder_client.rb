require 'TinderHTTP/request'


# RinderClient is the first and the only class you have to initialize to interact with the Tinder API
#
# ex:
# client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
#
# # Get recommendations
# recommendations = client.get_recommendations
#
# # Like (Swipe right) all the users recommended
# recommendations.result.each { |r| client.like(r) }
#
# # OR
#
# # Pass (Swipe left) all the users recommended
# recommendations.result.each { |r| client.pass(r) }

class RinderClient

  attr_reader :request

  # Need your Facebook Email and Facebook Password in order to fetch Facebook Token, which is necessary for authentication
  # Notice: This will raise TinderAuthFetcher::FacebookAuthenticationError if it fails to fetch Facebook token
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  def initialize(email, password)
    @request = init_request(email, password)
  end

  # Get Array of recommendations. You should pass each each recommendation to #like or #pass
  # We recommend execute #update_location before you #get_recommendations
  # @Return: OpenStruct{result: Array of recommendations, error: Error message, raw_response: Raw response from the Tinder API (Faraday::Resonse)}
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  # client.update_location(lat: 35.689407, lon: 139.700306)
  #
  # recommendations = client.get_recommendations.result
  def get_recommendations
    request.recommendations
  end

  # Like (Swipe right) one recommendation
  # @Argument recommendation: One of the return value from #get_recommendations
  # @Argument interval_sec:   Default = 1 second, interval second between like request to the Tinder API, we recommend between 0.5 sec - 1 sec
  # @Return OpenStruct{result: raw response, error: Error message, raw_response: Raw response from the Tinder API (Faraday::Resonse)}
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  # client.update_location(lat: 35.689407, lon: 139.700306)
  #
  # recommendations = client.get_recommendations
  # recommendations.result.each { |r| client.like(r) }
  def like(recommendation, interval_sec = 1)
    request.like(recommendation, interval_sec)
  end

  # Pass (Swipe left) one recommendation
  # @Argument recommendation: One of the return value from #get_recommendations
  # @Argument interval_sec:   Default = 1 second, interval second between like request to the Tinder API, we recommend between 0.5 sec - 1 sec
  # @Return OpenStruct{result: raw response, error: Error message, raw_response: Raw response from the Tinder API (Faraday::Resonse)}
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  # client.update_location(lat: 35.689407, lon: 139.700306)
  #
  # recommendations = client.get_recommendations
  # recommendations.result.each { |r| client.pass(r) }
  def pass(recommendation, interval_sec = 1)
    request.like(recommendation, interval_sec)
  end

  # Get you account's meta data
  # @Return OpenStruct{result: raw response, error: Error message, raw_response: Raw response from the Tinder API (Faraday::Resonse)}
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  # meta_dada = client.get_mata.result
  def get_meta
    request.meta
  end

  # Get you Facebook friends info on Tinder
  # @Return OpenStruct{result: Array of Facebook friends on Tinder, error: Error message, raw_response: Raw response from the Tinder API (Faraday::Resonse)}
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  # friends = client.check_friends.result
  def check_friends
    request.friends
  end

  # Get you user's profile
  # @Return OpenStruct{result: Raw response, error: Error message, raw_response: Raw response from the Tinder API (Faraday::Resonse)}
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  # client.update_location(lat: 35.689407, lon: 139.700306)
  #
  # recommendations = client.get_recommendations
  # user = recommendations.first
  #
  # id = user[:_id]
  # client.check_user(id)
  def check_user(id)
    request.user(id)
  end

  # Update user's location
  # @Argument lat: latitude
  # @Argument lon: longitude
  # @Return OpenStruct{result: Raw response, error: Error message, raw_response: Raw response from the Tinder API (Faraday::Resonse)}
  #
  # ex.
  # client = RinderClient.new('your_facebook_email@email.com', 'your_facebook_password')
  # client.update_location(lat: 35.689407, lon: 139.700306)
  def update_location(lat:, lon:)
    request.ping(lat: lat, lon: lon)
  end

  private

  def init_request(email, password)
    TinderHTTP::Request.new(email, password)
  end
end
