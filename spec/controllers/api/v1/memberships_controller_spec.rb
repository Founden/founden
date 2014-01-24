require 'spec_helper'

describe Api::V1::MembershipsController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:membership_ids) { [] }

    before { get(:index, :ids => membership_ids) }

    subject(:api_memberships) { json_to_ostruct(response.body) }

    its(:memberships) { should be_empty }

    context 'when a valid membership ID is queried' do
      let(:membership) do
        Fabricate(:membership, :creator => user, :type => Friendship.name)
      end
      let(:membership_ids) { [membership.slug] }

      its('memberships.count') { should eq(1) }
      its('memberships.first.values.first') { should eq(membership.slug) }
    end

    context 'when an invalid membership ID is queried' do
      let(:membership) do
        Fabricate(:membership, :creator => user)
      end
      let(:membership_ids) { [membership.slug] }

      its(:memberships) { should be_empty }
    end
  end

  describe '#show' do
    let(:membership_id) {}

    before { get(:show, :id => membership_id) }

    subject(:api_membership) { json_to_ostruct(response.body, :membership) }

    context 'a friendship' do
      let(:membership) do
        Fabricate(:membership, :creator => user, :type => Friendship.name)
      end
      let(:membership_id) { membership.slug }

      its('keys.count') { should eq(4) }
      its(:id) { should_not be_blank }
      its(:created_at) { should_not be_blank }
      its(:user_id) { should eq(membership.user.slug) }
      its(:creator_id) { should eq(user.slug) }
    end

    context 'a conversation membership' do
      let(:membership) do
        Fabricate(:conversation, :user => user).conversation_memberships.first
      end
      let(:membership_id) { membership.slug }

      its('keys.count') { should eq(5) }
      its(:id) { should_not be_blank }
      its(:created_at) { should_not be_blank }
      its(:user_id) { should eq(membership.user.slug) }
      its(:creator_id) { should eq(user.slug) }
      its(:conversation_id) { should eq(membership.conversation.slug) }
    end

    context 'an invalid membership' do
      let(:membership) do
        Fabricate(:membership, :user => user)
      end
      let(:membership_id) { membership.slug }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

  describe '#destroy' do
    let(:membership_id) {}

    before { delete(:destroy, :id => membership_id) }

    subject { response }

    context 'a friendship' do
      let(:membership) do
        Fabricate(:membership, :creator => user, :type => Friendship.name)
      end
      let(:membership_id) { membership.slug }

      its(:status) { should eq(204) }
      its(:body) { should be_blank }
    end

    context 'a conversation membership' do
      let(:membership) do
        Fabricate(:conversation, :user => user).conversation_memberships.first
      end
      let(:membership_id) { membership.slug }

      its(:status) { should eq(204) }
      its(:body) { should be_blank }
    end

    context 'an invalid membership' do
      let(:membership) do
        Fabricate(:membership, :user => user)
      end
      let(:membership_id) { membership.slug }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end

  end

  describe '#create' do
    let(:conversation) { Fabricate(:conversation, :user => user) }
    let(:contact) do
      Fabricate(:membership, :creator => user, :type => Friendship.name).user
    end

    let(:attrs) do
      Fabricate.attributes_for(:membership, :creator => user,
        :user => contact, :conversation => conversation)
    end
    before { post(:create, :membership => attrs) }

    subject(:api_membership) { json_to_ostruct(response.body, :membership) }

    its('keys.count') { should eq(5) }
    its(:id) { should_not be_blank }
    its(:created_at) { should_not be_blank }
    its(:user_id) { should eq(attrs[:user_id]) }
    its(:creator_id) { should eq(user.slug) }
    its(:conversation_id) { should eq(attrs[:conversation_id]) }

    context 'when a conversation is not included' do
      let(:conversation) { nil }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end

    context 'when user reference is unavailable' do
      let(:attrs) do
        Fabricate.attributes_for(:membership, :creator => user, :user_id => '-')
      end

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end

    context 'when conversation reference is unavailable' do
      let(:attrs) do
        Fabricate.attributes_for(:membership, :creator => user,
          :conversation => Fabricate(:conversation))
      end

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end
  end
end
