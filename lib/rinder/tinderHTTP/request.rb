require 'tinder_auth_fetcher'
require 'faraday'
require 'faraday_middleware'
require 'json'
require_relative '../../../lib/rinder/tinderHTTP/response'

class Request

  USER_AGENT = 'Tinder/4.7.1 (iPhone; iOS 9.2; Scale/2.00)'.freeze
  BASE_URL = 'https://api.gotinder.com'.freeze
  URLS = { auth: '/auth', recs: '/user/recs', like: '/like/' }.freeze

  attr_accessor :x_auth_token

  def self.factory(email, password)
    instance = new
    res = instance.authentication(email, password)

    instance.instance_variable_set(:@x_auth_token, { 'X-Auth-Token' => res.body["token"] })
    instance
  end

  def recommendations
    res = get URLS[:recs], x_auth_token
    Response.initialize_recommendations(res)
  end

  def like(user)
    get URLS[:like] + user._id, x_auth_token
  end

  def authentication(email, password)
    facebook_token = TinderAuthFetcher.fetch_token(email, password)
    post(URLS[:auth], facebook_token: facebook_token)
  end

  private

  def post(url, body, opts = {})
    c = form_connection(opts)
    c.post url, body
  end

  def get(url, opts = {})
    c = form_connection(opts)
    c.get url
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
