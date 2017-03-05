require 'spec_helper'
require_relative '../../../lib/rinder/profile/photo/client_photo'

RSpec.describe ClientPhoto do
  let(:data){
    {
      "id": "fea4f480-7ce0-4143-a310-a03c2b2cdbc6",
      "url": "http://images.gotinder.com/518d666a2a00df0e490000b9/fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg",
      "fbId": "directupload",
      "extension": "jpg",
      "fileName": "fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg",
      "successRate": 0.0262582056892779,
      "selectRate": 0,
      "processedFiles": [{
                           "width": 640,
                           "height": 640,
                           "url": "http://images.gotinder.com/518d666a2a00df0e490000b9/640x640_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
                         }, {
                           "width": 320,
                           "height": 320,
                           "url": "http://images.gotinder.com/518d666a2a00df0e490000b9/320x320_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
                         }, {
                           "width": 172,
                           "height": 172,
                           "url": "http://images.gotinder.com/518d666a2a00df0e490000b9/172x172_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
                         }, {
                           "width": 84,
                           "height": 84,
                           "url": "http://images.gotinder.com/518d666a2a00df0e490000b9/84x84_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
                         }],

    }
  }
  let(:client_photo){ClientPhoto.new(data)}

  describe '#initialize' do
    it 'should have the expected properties' do
      ClientPhoto::PROPERTIES.each do |p|
        eval "expect(client_photo.#{p}).to eq(data[#{':' + p}])"
      end
    end
  end
end
