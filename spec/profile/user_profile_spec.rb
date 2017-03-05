require 'spec_helper'
require_relative '../../lib/rinder/profile/user_profile'
require_relative '../../lib/rinder/profile/photo/user_photo'

RSpec.describe UserProfile do
  # FIXME: Write helper to fetch the real recs in order to guarantee this mode is up-to-date.

  let(:data) {
    {
      "distance_mi": 3,
      "connection_count": 322,
      "common_likes": [],
      "common_friends": [],
      "content_hash": "some hash",
      "_id": "some id",
      "badges": [],
      "bio": "cool bio",
      "birth_date": "1994-03-08T04:41:40.560Z",
      "name": "Someone",
      "ping_time": "2017-03-04T15:08:17.478Z",
      "photos": [
        {
          "id": "p1",
          "url": "p1 url",
          "processedFiles": [
            {
              "width": 640,
              "height": 640,
              "url": "p1640"
            },
            {
              "width": 320,
              "height": 320,
              "url": "p1320"
            },
            {
              "width": 172,
              "height": 172,
              "url": "p1172"
            },
            {
              "width": 84,
              "height": 84,
              "url": "p184"
            }
          ]
        },
        {
          "id": "p2",
          "url": "p2 url",
          "processedFiles": [
            {
              "url": "p2640",
              "height": 640,
              "width": 640
            },
            {
              "url": "p2320",
              "height": 320,
              "width": 320
            },
            {
              "url": "p2172",
              "height": 172,
              "width": 172
            },
            {
              "url": "p284",
              "height": 84,
              "width": 84
            }
          ]
        }
      ],
      "jobs": ["Some job"],
      "schools": ["Some school"],
      "teaser": {
        "string": ""
      },
      "teasers": [],
      "s_number": 130529713,
      "gender": 1,
      "birth_date_info": "fuzzy birthdate active, not displaying real birth_date"
    }
  }
  let(:profile) { UserProfile.new(data) }

  describe '#initialize' do
    it 'should have the expected properties' do
      UserProfile::PROPERTIES.each do |p|
        if p == 'photos'
          expect(profile.photos).to eq(data[:photos].map { |p| UserPhoto.new(p) })
        elsif p == 'birth_date' || p == 'ping_time'
          eval "expect(profile.#{p}).to eq(DateTime.parse(data[#{':' + p}]))"
        else
          eval "expect(profile.#{p}).to eq(data[#{':' + p}])"
        end
      end
    end
  end
end
