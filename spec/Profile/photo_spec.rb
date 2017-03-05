require 'spec_helper'
require_relative '../../lib/rinder/Profile/photo'

RSpec.describe Photo do
  let(:data){
    {
      "id": "fea4f480-7ce0-4143-a310-a03c2b2cdbc6",
      "main": true,
      "crop": "source",
      "fileName": "fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg",
      "extension": "jpg",
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
      "url": "http://images.gotinder.com/518d666a2a00df0e490000b9/fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
    }
  }
  let(:photo){Photo.new(data)}

  describe '#initialize' do
    it 'should have the expected properties' do
      Photo::PROPERTIES.each do |p|
        eval "expect(photo.#{p}).to eq(data[#{':' + p}])"
      end
    end
  end
end
