require 'spec_helper'

describe Api::V1::MessagesController do

  describe 'routing' do

    it 'for showing messages' do
      get('/api/v1/messages').should route_to('api/v1/messages#index')
    end

    it 'for showing a message' do
      get('/api/v1/messages/1').should route_to(
        'api/v1/messages#show', :id => '1')
    end

    it 'for creating a message' do
      post('/api/v1/messages').should route_to(
        'api/v1/messages#create')
    end

    it 'for updating a message' do
      patch('/api/v1/messages/ID').should route_to(
        'api/v1/messages#update', :id => 'ID')
    end

  end
end
