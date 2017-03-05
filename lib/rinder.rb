require "rinder/version"
require "tinder_auth_fetcher"

module Rinder

  def initialize(email, password)
    @client = Client.new(email, password)
  end
end
