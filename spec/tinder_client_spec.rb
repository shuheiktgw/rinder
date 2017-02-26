require "spec_helper"
require_relative '../lib/runder/tinder_client'

RSpec.describe TinderClient do

  describe '#get_token' do
    it 'should return token' do
      client = TinderClient.new('test', 'test')
      expect(client.token.length).not_to eq(0)
    end
  end
end
