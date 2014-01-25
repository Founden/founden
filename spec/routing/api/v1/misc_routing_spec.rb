require 'spec_helper'

describe Api::V1::MiscController do

  describe 'routing' do

    it 'for websocket endpoint' do
      get('/api/v1/socket').should route_to('api/v1/misc#websocket')
    end

    it 'for md5 endpoint' do
      get('/api/v1/md5').should route_to('api/v1/misc#md5')
    end

  end
end

