require 'spec_helper'
require_relative '../../lib/rinder/tinderHTTP/request'

RSpec.describe TinderHTTP::Request do

  describe '#new' do
    context 'if valid email and password are given' do
      it 'should return request instance with x_auth_token' do
        request = TinderHTTP::Request.new(ENV['RINDER_FB_EMAIL'], ENV['RINDER_FB_PASSWORD'])
        expect(request.x_auth_token['X-Auth-Token']).not_to be_empty
      end
    end

    context 'if invalid email and password are given' do
      it 'should raise TinderAuthFetcher::FacebookAuthenticationError' do
        expect{ TinderHTTP::Request.new('invalid@email.com', 'invalidpassword') }.to raise_error TinderAuthFetcher::FacebookAuthenticationError
      end
    end
  end

  context 'after authentication' do
    before :all do
      @request = TinderHTTP::Request.new(ENV['RINDER_FB_EMAIL'], ENV['RINDER_FB_PASSWORD'])
    end

    describe '#recommendations' do
      it 'should return recommendations' do
        recs = @request.recommendations
        expect(recs.error).to be_empty
        expect(recs.result.length).not_to eq(0)
      end
    end

    describe '#like' do
      it 'should be able to like user' do
        recs = @request.recommendations
        recs.result.each do |r|
          res = @request.like(r)
          expect(res.error).to be_empty
        end
      end
    end

    describe '#pass' do
      it 'should be able to pass user' do
        recs = @request.recommendations
        recs.result.each do |r|
          res = @request.pass(r)
          expect(res.error).to be_empty
        end
      end
    end

    describe '#ping' do
      it 'should be able to change location' do
        lat = 35.689407
        lon = 139.700306

        res = @request.ping(lat: lat, lon: lon)
        expect(res.error).to be_empty
      end
    end
  end
end

