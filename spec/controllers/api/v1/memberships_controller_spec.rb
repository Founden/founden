require 'spec_helper'

describe Api::V1::MembershipsController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#create' do
    let(:attrs) do
      Fabricate.attributes_for(
        :membership, :creator => user, :network => user.networks.first)
    end
    before { post(:create, :membership => attrs) }

    subject(:api_membership) { json_to_ostruct(response.body, :membership) }

    its('keys.count') { should eq(5) }
    its(:id) { should_not be_blank }
    its(:created_at) { should_not be_blank }
    its(:network_id) { should eq(attrs[:network_id]) }
    its(:user_id) { should eq(attrs[:user_id]) }
    its(:creator_id) { should eq(user.slug) }

    context 'when a conversation is included' do
      let(:conversation) do
        Fabricate(:conversation, :user => user, :network => user.networks.first)
      end
      let(:attrs) do
        Fabricate.attributes_for(:membership, :creator => user,
                                 :network => user.networks.first, :conversation => conversation)
      end

      its('keys.count') { should eq(6) }
      its(:id) { should_not be_blank }
      its(:created_at) { should_not be_blank }
      its(:network_id) { should eq(attrs[:network_id]) }
      its(:conversation_id) { should eq(attrs[:conversation_id]) }
      its(:user_id) { should eq(attrs[:user_id]) }
      its(:creator_id) { should eq(user.slug) }
    end

    context 'when user reference is unavailable' do
      let(:attrs) do
        Fabricate.attributes_for(:membership, :creator => user, :user_id => '-',
          :network => user.networks.first)
      end

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end

    context 'when network reference is unavailable' do
      let(:attrs) do
        Fabricate.attributes_for(:membership, :creator => user,
          :network => Fabricate(:network))
      end

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end

    context 'when conversation reference is unavailable' do
      let(:attrs) do
        Fabricate.attributes_for(:membership, :creator => user,
          :network => user.networks.first,
          :conversation => Fabricate(:conversation))
      end

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end
  end
end
