require 'spec_helper'

describe Api::V1::NetworksController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:network_ids) { [] }

    before { get(:index, :ids => network_ids) }

    subject(:api_networks) { json_to_ostruct(response.body) }

    its('networks.count') { should eq(0) }

    context 'when current user has networks' do
      let(:network_ids) { user.networks.map(&:slug) }

      its('networks.count') { should eq(1) }
    end
  end

  describe '#show' do
    let(:network) { Fabricate(:network, :user => user) }
    let(:network_id) { network.slug }

    before { get(:show, :id => network_id) }

    subject(:api_network) { json_to_ostruct(response.body, :network) }

    its('keys.size') { should eq(4) }
    its(:id) { should eq(network.slug) }
    its(:title) { should eq(network.title) }
    its(:user_id) { should eq(network.user.slug) }
    its('conversation_ids.count') { should eq(network.conversations.count) }

    context 'when network id is not available' do
      let(:network_id) { rand(100) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

end
