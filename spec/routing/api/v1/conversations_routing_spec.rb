require 'spec_helper'

describe Api::V1::ConversationsController do

  describe 'routing' do

    it 'for showing conversations' do
      get('/api/v1/conversations').should route_to('api/v1/conversations#index')
    end

    it 'for showing a conversation' do
      get('/api/v1/conversations/1').should route_to(
        'api/v1/conversations#show', :id => '1')
    end

    it 'for creating a conversation' do
      post('/api/v1/conversations').should route_to(
        'api/v1/conversations#create')
    end

  end
end
