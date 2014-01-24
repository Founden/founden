require 'spec_helper'

describe Api::V1::MembershipsController do

  describe 'routing' do

    it 'for listing memberships' do
      get('/api/v1/memberships').should route_to('api/v1/memberships#index')
    end

    it 'for showing a membership' do
      get('/api/v1/memberships/1').should route_to(
        'api/v1/memberships#show', :id => '1')
    end

    it 'for creating a membership' do
      post('/api/v1/memberships').should route_to('api/v1/memberships#create')
    end

    it 'for deleting a membership' do
      delete('/api/v1/memberships/1').should route_to(
        'api/v1/memberships#destroy', :id => '1')
    end

  end
end

