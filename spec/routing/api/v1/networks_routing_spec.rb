require 'spec_helper'

describe Api::V1::NetworksController do

  describe 'routing' do

    it 'for showing networks' do
      get('/api/v1/networks').should route_to('api/v1/networks#index')
    end

    it 'for showing a network' do
      get('/api/v1/networks/1').should route_to(
        'api/v1/networks#show', :id => '1')
    end

  end
end
