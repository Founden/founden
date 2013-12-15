require 'spec_helper'

describe Api::V1::MembershipsController do

  describe 'routing' do

    it 'for creating a membership' do
      post('/api/v1/memberships').should route_to('api/v1/memberships#create')
    end

  end
end

