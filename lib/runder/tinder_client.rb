require 'tinder_auth_fetcher'
require 'faraday'
require 'json'

class TinderClient

  attr_reader :token

  BASE_URL = 'https://api.gotinder.com'.freeze

  def initialize(email, password)
    @token = get_token(email, password)
  end

  def get_token(email, password)
    auth_token = TinderAuthFetcher.fetch_token(email, password)

    conn = Faraday.new(url: BASE_URL + '/auth')
    res = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['User-Agent'] = 'Tinder/4.6.1 (iPhone; iOS 8.1.1; Scale/2.00)'
      req.body = "{'facebook_token': #{auth_token}}"
    end

    Json.parse(res)[:token]
  end
end
