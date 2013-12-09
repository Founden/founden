require 'spec_helper'

describe Api::V1::ConversationsController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:conversation_ids) { user.conversations.map(&:slug) }

    before { get(:index, :ids => conversation_ids) }

    subject(:api_conversations) { json_to_ostruct(response.body) }

    its('conversations.count') { should eq(0) }

    context 'when current user has conversations' do
      let(:user) { Fabricate(:conversation).user }

      its('conversations.count') { should eq(1) }
    end
  end

  describe '#show' do
    let(:conversation) { Fabricate(:conversation, :user => user) }
    let(:conversation_id) { conversation.slug }

    before { get(:show, :id => conversation_id) }

    subject(:api_conversation) { json_to_ostruct(response.body, :conversation) }

    its('keys.size') { should eq(5) }
    its(:id) { should eq(conversation.slug) }
    its(:title) { should eq(conversation.title) }
    its(:user_id) { should eq(conversation.user.slug) }
    its(:network_id) { should eq(conversation.network.slug) }
    its('message_ids.count') { should eq(conversation.messages.count) }

    context 'when conversation id is not available' do
      let(:conversation_id) { rand(100) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

  describe '#create' do
    let(:network) { Fabricate(:network, :user => user) }
    let(:attrs) { Fabricate.attributes_for(
      :conversation, :network_id => network.slug, :user => user) }

    before { post(:create, :conversation => attrs) }

    subject(:api_conversation) { json_to_ostruct(response.body, :conversation) }

    its('keys.size') { should eq(5) }
    its(:id) { should_not be_blank }
    its(:title) { should eq(attrs[:title]) }
    its(:user_id) { should eq(user.slug) }
    its(:network_id) { should eq(attrs[:network_id]) }
    its(:message_ids) { should be_empty }

    context 'when title is missing' do
    let(:attrs) { Fabricate.attributes_for(
      :conversation, :network_id => network.slug, :user => user, :title => nil)}

      subject { response }

      its(:status) { should eq(400) }
      its(:body) { should include("Title can't be blank") }
    end

    context 'when network id is not available' do
      let(:attrs) { Fabricate.attributes_for(:conversation, :network_id => 0) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

end
