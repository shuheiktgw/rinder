require 'spec_helper'
require_relative '../../lib/rinder/tinderHTTP/request'

RSpec.describe TinderHTTP::Request do

  describe 'Request#new' do
    it 'should return request instance with x_auth_token' do
      request = TinderHTTP::Request.new(ENV['RINDER_FB_EMAIL'], ENV['RINDER_FB_PASSWORD'])
      expect(request.x_auth_token.length).not_to eq(0)
    end
  end

  context 'after authentication' do
    before :all do
      @request = TinderHTTP::Request.new(ENV['RINDER_FB_EMAIL'], ENV['RINDER_FB_PASSWORD'])
    end

    describe '#recommendations' do
      it 'shoutinld return recommendations' do
        recs = @request.recommendations
        expect(recs.result.length).not_to eq(0)
        expect(recs.message).to be_empty
      end
    end

    describe '#like' do
      it 'should be able to like user' do
        recs = @request.recommendations
        recs.result.each do |r|
          res = @request.like(r)
          expect(res.message).to be_empty
        end
      end
    end
  end
end

