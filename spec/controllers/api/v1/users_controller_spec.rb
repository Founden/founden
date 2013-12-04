require 'spec_helper'

describe Api::V1::UsersController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    before { get(:index) }

    subject(:api_user) { json_to_ostruct(response.body) }

    its('users.count') { should eq(1) }
  end

  describe '#show' do
    include AvatarHelper

    let(:network) { Fabricate(:network, :user => user) }
    let(:user_id) { network.user.slug }

    before { get(:show, :id => user_id) }

    subject(:api_user) { json_to_ostruct(response.body, :user) }

    shared_examples 'shows current user details' do
      its('keys.size') { should eq(5) }
      its(:id) { should eq(user.slug) }
      its(:first_name) { should eq(user.first_name) }
      its(:last_name) { should eq(user.last_name) }
      its(:avatar_url) { should eq(avatar_uri(user)) }
      its('network_ids.size') { should eq(user.networks.count) }
    end

    context 'if user is the logged in' do
      it_should_behave_like 'shows current user details'
    end

    context 'if profile id is not found' do
      let(:user_id) { 'mine' }
      it_should_behave_like 'shows current user details'
    end

    context 'shows limited details if user is not logged in' do
      let(:some_user) { Fabricate(:user) }
      let(:user_id) { some_user.slug }

      its('keys.size') { should eq(4) }
      its(:id) { should eq(some_user.slug) }
      its(:first_name) { should eq(some_user.first_name) }
      its(:last_name) { should eq(some_user.last_name) }
      its(:avatar_url) { should eq(gravatar_uri(some_user.email)) }
    end
  end
end
