require 'tinder_auth_fetcher'
require 'faraday'
require 'faraday_middleware'
require 'json'

class Request

  USER_AGENT = 'Tinder/4.7.1 (iPhone; iOS 9.2; Scale/2.00)'.freeze
  BASE_URL = 'https://api.gotinder.com'.freeze
  URLS = { auth: '/auth', recs: '/user/recs' }.freeze

  attr_accessor :x_auth_token

  def initialize(token)
    @x_auth_token = { 'X-Auth-Token' => token }
  end

  def self.factory(email, password)
    res = authentication(email, password)
    instance = Request.new(res["token"])
    return instance, res
  end

  def recommendations
    res = get URLS[:recs], x_auth_token
    users = res["results"].map { |r| Profile.new(r) }
  end

  private

  def authentication(email, password)
    facebook_token = TinderAuthFetcher.fetch_token(email, password)
    post(URLS[:auth], facebook_token: facebook_token)
  end

  def post(url, body, opts = {})
    c = form_connection(opts)
    c.post url, body
  end

  def get(url, opts={})
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
