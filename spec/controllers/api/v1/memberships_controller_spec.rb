require 'spec_helper'

describe Api::V1::MembershipsController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#create' do
    let(:conversation) { Fabricate(:conversation, :user => user) }
    let(:attrs) do
      Fabricate.attributes_for(
        :membership, :creator => user, :conversation => conversation)
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
