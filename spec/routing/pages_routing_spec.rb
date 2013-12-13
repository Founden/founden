require 'spec_helper'

describe 'Pages' do

  describe 'routing' do

    it 'for dashboard page' do
      get('/dashboard').should route_to('pages#dashboard')
    end

    it 'for waiting page' do
      get('/waiting').should route_to('pages#waiting')
    end

    it 'for updating waiting page' do
      patch('/waiting').should route_to('pages#waiting')
    end

  end
end
