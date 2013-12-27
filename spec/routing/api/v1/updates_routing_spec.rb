require 'spec_helper'

describe Api::V1::UpdatesController do

  describe 'routing' do

    it 'for websocket endpoint' do
      get('/api/v1/updates').should route_to('api/v1/updates#index')
    end

  end
end

