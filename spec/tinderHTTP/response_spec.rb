require 'spec_helper'
require_relative '../../lib/rinder/tinderHTTP/response'
require_relative '../../lib/rinder/profile/user_profile'

RSpec.describe Response do
  # FIXME: Write helper to fetch the real recs in order to guarantee this mode is up-to-date.

  let(:data) {
    {
      status: 200,
      results: [
        {
          "distance_mi": 3,
          "connection_count": 322,
          "common_likes": [],
          "common_friends": [],
          "content_hash": "content hash",
          "_id": "12345",
          "badges": [],
          "bio": "I'm awesome",
          "birth_date": "1994-03-08T04:41:40.560Z",
          "name": "Test Name",
          "ping_time": "2017-03-04T15:08:17.478Z",
          "photos": [
            {
              "id": "12345",
              "url": "url",
              "processedFiles": [
                {
                  "width": 640,
                  "height": 640,
                  "url": "url640"
                },
                {
                  "width": 320,
                  "height": 320,
                  "url": "url320"
                },
                {
                  "width": 172,
                  "height": 172,
                  "url": "url172"
                },
                {
                  "width": 84,
                  "height": 84,
                  "url": "url82"
                }
              ]
            },
            {
              "id": "abcde",
              "url": "url",
              "processedFiles": [
                {
                  "url": "url640",
                  "height": 640,
                  "width": 640
                },
                {
                  "url": "url320",
                  "height": 320,
                  "width": 320
                },
                {
                  "url": "url172",
                  "height": 172,
                  "width": 172
                },
                {
                  "url": "url84",
                  "height": 84,
                  "width": 84
                }
              ]
            }
          ],
          "jobs": [],
          "schools": [],
          "teaser": {
            "string": ""
          },
          "teasers": [],
          "s_number": 130529713,
          "gender": 1,
          "birth_date_info": "fuzzy birthdate active, not displaying real birth_date"
        },
        {
          "distance_mi": 1,
          "connection_count": 291,
          "common_likes": [],
          "common_friends": [],
          "content_hash": "hash",
          "_id": "djaiofj",
          "bio": "I'm more awesome",
          "birth_date": "1996-03-08T04:41:40.564Z",
          "name": "Test Name",
          "ping_time": "2017-03-05T04:19:33.627Z",
          "photos": [
            {
              "id": "12345",
              "url": "url",
              "processedFiles": [
                {
                  "url": "url640",
                  "height": 640,
                  "width": 640
                },
                {
                  "url": "url320",
                  "height": 320,
                  "width": 320
                },
                {
                  "url": "url172",
                  "height": 172,
                  "width": 172
                },
                {
                  "url": "url84",
                  "height": 84,
                  "width": 84
                }
              ]
            },
            {
              "id": "12345",
              "url": "url",
              "processedFiles": [
                {
                  "url": "url640",
                  "height": 640,
                  "width": 640
                },
                {
                  "url": "url320",
                  "height": 320,
                  "width": 320
                },
                {
                  "url": "url172",
                  "height": 172,
                  "width": 172
                },
                {
                  "url": "url84",
                  "height": 84,
                  "width": 84
                }
              ]
            }
          ],
          "jobs": [],
          "schools": [
            {
              "id": "143186452415116",
              "name": "Kyoritsu Womens University"
            }
          ],
          "teaser": {
            "type": "school",
            "string": "Kyoritsu Womens University"
          },
          "teasers": [
            {
              "type": "school",
              "string": "Kyoritsu Womens University"
            },
            {
              "type": "sameInterests",
              "string": "1 Common Interest"
            }
          ],
          "s_number": 12345,
          "gender": 1,
          "birth_date_info": "fuzzy birthdate active, not displaying real birth_date"
        }
      ]
    }
  }

  describe '#self.initialize_recommendations' do
    before do
      response_mock = double('Faraday Response Mock')
      allow(response_mock).to receive(:body).and_return(data)
      allow(response_mock).to receive(:status).and_return(200)

      @response = Response.initialize_recommendations(response_mock)
    end

    it 'should return recommendations' do
      expected = data[:results].map{|p| UserProfile.new(p)}

      expect(@response.recommendations).to eq(expected)
    end

    it 'should delegate to undefined method to faraday response class' do
      expect(@response.status).to eq(200)
    end
  end
end
