require 'spec_helper'

describe Api::V1::AttachmentsController do

  describe 'routing' do

    it 'for showing attachments' do
      get('/api/v1/attachments').should route_to('api/v1/attachments#index')
    end

    it 'for showing an attachment' do
      get('/api/v1/attachments/1').should route_to(
        'api/v1/attachments#show', :id => '1')
    end

    it 'for updating an attachment' do
      put('/api/v1/attachments/1').should route_to(
        'api/v1/attachments#update', :id => '1')
    end

    it 'for creating an attachment' do
      post('/api/v1/attachments').should route_to(
        'api/v1/attachments#create')
    end

  end
end
