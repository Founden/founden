require 'spec_helper'

describe Api::V1::NetworksController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    before { get(:index) }

    subject(:api_networks) { json_to_ostruct(response.body) }

    its('networks.count') { should eq(0) }

    context 'when current user has networks' do
      let(:user) { Fabricate(:network).user }

      its('networks.count') { should eq(1) }
    end
  end

  describe '#show' do
    let(:network) { Fabricate(:network, :user => user) }
    let(:network_id) { network.slug }

    before { get(:show, :id => network_id) }

    subject(:api_network) { json_to_ostruct(response.body, :network) }

    its('keys.size') { should eq(3) }
    its(:id) { should eq(network.slug) }
    its(:title) { should eq(network.title) }
    its('conversation_ids.count') { should eq(network.conversations.count) }

    context 'when network id is not available' do
      let(:network_id) { rand(100) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

end
