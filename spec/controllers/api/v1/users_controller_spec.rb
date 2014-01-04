require 'spec_helper'
require 'membership'

describe Api::V1::UsersController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:user_ids) { [] }
    before { get(:index, :ids => user_ids) }

    subject(:api_user) { json_to_ostruct(response.body) }

    its('users.count') { should eq(1) }

    context 'when a valid user ID is queried' do
      let(:some_user) { Fabricate(:user) }
      let(:user_ids) { [some_user.slug] }

      its('users.count') { should eq(1) }
      its('users.first.values.first') { should eq(some_user.slug) }
    end
  end

  describe '#show' do
    include AvatarHelper

    let!(:friendship) do
      Fabricate(:membership, :type => Friendship.name, :creator => user)
    end
    let(:user_id) { friendship.creator.slug }

    before { get(:show, :id => user_id) }

    subject(:api_user) { json_to_ostruct(response.body, :user) }

    shared_examples 'shows current user details' do
      its('keys.size') { should eq(5) }
      its(:id) { should eq(user.slug) }
      its(:first_name) { should eq(user.first_name) }
      its(:last_name) { should eq(user.last_name) }
      its(:avatar_url) { should eq(avatar_uri(user)) }
      its(:contact_ids) { should include(friendship.user.slug) }
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
