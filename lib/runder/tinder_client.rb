require 'tinder_auth_fetcher'
require 'faraday'
require 'faraday_middleware'
require 'json'

class TinderClient

  attr_reader :token

  BASE_URL = 'https://api.gotinder.com'.freeze

  def initialize(email, password)
    @token = get_token(email, password)
  end

  # Memo: Might wanna make TinderHTTP class to wrap faraday
  def get_token(email, password)
    facebook_token = TinderAuthFetcher.fetch_token(email, password)

    conn = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :json
      faraday.response :json
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    conn.headers['User-Agent'] = 'Tinder/4.6.1 (iPhone; iOS 8.1.1; Scale/2.00)'
    res = conn.post '/auth', facebook_token: facebook_token

    res.body["token"]
  end
end
