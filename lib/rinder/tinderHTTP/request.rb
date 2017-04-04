require 'tinder_auth_fetcher'
require 'faraday'
require 'faraday_middleware'
require 'json'
require './tinderHTTP/responsible'

module TinderHTTP
  class Request
    include TinderHTTP::Responsible

    USER_AGENT = 'Tinder/4.7.1 (iPhone; iOS 9.2; Scale/2.00)'.freeze
    BASE_URL = 'https://api.gotinder.com'.freeze
    URLS = { auth: '/auth', recs: '/user/recs', like: '/like/' }.freeze

    attr_accessor :x_auth_token
    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
      res = authenticate(email, password)
      @x_auth_token = { 'X-Auth-Token' => res.body['token'] }
    end

    def recommendations
      get URLS[:recs], x_auth_token, recommendations_handler
    end

    # TODO: If user's "name" attribute is "Tinder Team", you are out of likes so write a piece of code to handle it
    def like(recs, sleep_sec = 0.5)
      recs['results'].each do |r|


      end



      res = get URLS[:like] + user['_id'], x_auth_token
      sleep sleep_sec
      res
    end

    private

    def authenticate(email, password)
      facebook_token = TinderAuthFetcher.fetch_token(email, password)
      post(URLS[:auth], facebook_token: facebook_token)
    end

    def post(url, body, opts = {}, response_handler = nil)
      connect(opts, response_handler){ |c| c.post url, body }
    end

    def get(url, opts = {}, response_handler = nil)
      connect(opts, response_handler){ |c| c.get url }
    end

    def connect(opts, response_handler)
      c = form_connection(opts)
      res = yield(c)

      if response_handler
        response_handler.call(res)
      else
        res
      end
    end

    def form_connection(opts = {})
      c = Faraday.new(url: BASE_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end

      c.headers['User-Agent'] = USER_AGENT
      opts.each { |k, v| c.headers[k] = v }

      c
    end
  end
end
