require "runder/version"
require "tinder_auth_fetcher"

module Runder

  def initialize(email, password)
    @client = Client.new(email, password)
  end
end
