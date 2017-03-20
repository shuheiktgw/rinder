require "spec_helper"
require_relative '../../lib/rinder/tinderHTTP/request'

RSpec.describe Request do

  describe 'Request#factory' do
    it 'should return request instance with x_auth_token' do
      request = Request.factory(ENV['RINDER_FB_EMAIL'], ENV['RINDER_FB_PASSWORD'])
      expect(request.x_auth_token.length).not_to eq(0)
    end
  end

  context 'after authentication' do
    before :all do
      @request = Request.factory(ENV['RINDER_FB_EMAIL'], ENV['RINDER_FB_PASSWORD'])
    end

    describe '#recommendations' do
      it 'should return recommendations' do
        recs = @request.recommendations
        expect(recs.recommendations.length).not_to eq(0)
      end
    end

    describe '#like' do
      it 'should be able to like users' do
        recs = @request.recommendations
        puts recs.recommendations
        recs.recommendations.map do |r|
          res = @request.like(r)
          expect(res.status).to eq(200)
        end
      end
    end
  end
end

