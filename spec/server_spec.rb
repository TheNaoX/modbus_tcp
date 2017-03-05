require 'spec_helper'

describe Server do
  describe 'GET /scale.xml' do
    it 'is success' do
      get '/scale.xml'

      expect(last_response).to be_ok
    end

    it 'returns the XML values' do
      get '/scale.xml'

      expect(last_response.content_type).to eq "application/xml;charset=utf-8"
      expect(last_response.body).to match /scaleItem/
      expect(last_response.body).to match /value/
    end
  end
end
