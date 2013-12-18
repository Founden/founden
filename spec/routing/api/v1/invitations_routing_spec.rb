require 'spec_helper'

describe Api::V1::InvitationsController do

  describe 'routing' do

    it 'for listing invitation' do
      get('/api/v1/invitations').should route_to('api/v1/invitations#index')
    end

    it 'for creating an invitation' do
      post('/api/v1/invitations').should route_to('api/v1/invitations#create')
    end

  end
end

