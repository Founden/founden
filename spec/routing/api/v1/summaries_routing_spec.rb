require 'spec_helper'

describe Api::V1::SummariesController do

  describe 'routing' do

    it 'for showing summaries' do
      get('/api/v1/summaries').should route_to('api/v1/summaries#index')
    end

    it 'for showing a summary' do
      get('/api/v1/summaries/1').should route_to(
        'api/v1/summaries#show', :id => '1')
    end

  end
end
