require 'tinder_auth_fetcher'
require 'faraday'
require 'faraday_middleware'
require 'json'
require_relative '../tinderHTTP/responsible'

module TinderHTTP
  class Request
    include TinderHTTP::Responsible

    USER_AGENT = 'Tinder/4.7.1 (iPhone; iOS 9.2; Scale/2.00)'.freeze
    BASE_URL = 'https://api.gotinder.com'.freeze
    URLS = {
      auth: '/auth',
      recs: '/user/recs',
      like: '/like/',
      pass: '/pass/',
      meta: '/meta',
      friends: '/group/friends',
      user: '/user/',
      ping: '/user/ping'
    }.freeze

    attr_accessor :x_auth_token
    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
      @facebook_token = TinderAuthFetcher.fetch_token(email, password)
      @x_auth_token = { 'X-Auth-Token' => authenticate[:result] }
    end

    def recommendations
      get url: URLS[:recs], opts: x_auth_token, response_handler: RECOMMENDATIONS_HANDLER
    end

    def like(rec, sleep_sec = 1)
      res = get url: URLS[:like] + rec['_id'], opts: x_auth_token, response_handler: BASIC_HANDLER
      sleep sleep_sec
      res
    end

    def pass(rec, sleep_sec = 1)
      res = get url: URLS[:pass] + rec['_id'], opts: x_auth_token, response_handler: BASIC_HANDLER
      sleep sleep_sec
      res
    end

    def meta
      get url: URLS[:meta], opts: x_auth_token, response_handler: BASIC_HANDLER
    end

    def friends
      get url: URLS[:friends], opts: x_auth_token, response_handler: FRIENDS_HANDLER
    end

    def user(id)
      get url: URLS[:pass] + id, opts: x_auth_token, response_handler: BASIC_HANDLER
    end

    def ping(lat:, lon:)
      post(url: URLS[:auth], body: { lat: lat, lon: lon }, opts: x_auth_token, response_handler: BASIC_HANDLER)
    end

    private

    def authenticate
      post(url: URLS[:auth], response_handler: AUTHENTICATION_HANDLER)
    end

    def post(url:, body:{}, opts: {}, response_handler: nil)
      b = { facebook_token: @facebook_token }.merge(body)
      connect(opts, response_handler) { |c| c.post url, b }
    end

    def get(url:, opts: {}, response_handler: nil)
      connect(opts, response_handler) { |c| c.get url }
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
