require "spec_helper"
require_relative '../lib/rinder/tinder_client'

RSpec.describe TinderClient do

  describe '#get_token' do
    it 'should return token' do
      client = TinderClient.new(ENV['RINDER_FB_EMAIL'], ENV['RINDER_FB_PASSWORD'])
      expect(client.token.length).not_to eq(0)
    end
  end

  describe ''
end
