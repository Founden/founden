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

    its('keys.size') { should eq(8) }
    its(:id) { should eq(conversation.slug) }
    its(:created_at) { should eq(conversation.created_at.as_json) }
    its(:title) { should eq(conversation.title) }
    its(:user_id) { should eq(conversation.user.slug) }
    its(:network_id) { should eq(conversation.network.slug) }
    its(:summary_id) { should be_blank }
    its('message_ids.count') { should eq(conversation.messages.count) }
    its('participant_ids.count') { should eq(conversation.participants.count) }

    context 'when conversation has a summary' do
      let(:conversation) { Fabricate(:summary, :user => user).conversation }

      its('keys.size') { should eq(8) }
      its(:summary_id) { should eq(conversation.summary.slug) }
    end

    context 'when conversation id is not available' do
      let(:conversation_id) { rand(100) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

  describe '#create' do
    let(:attrs) { Fabricate.attributes_for(:conversation, :user => user) }

    before { post(:create, :conversation => attrs) }

    subject(:api_conversation) { json_to_ostruct(response.body, :conversation) }

    its('keys.size') { should eq(8) }
    its(:id) { should_not be_blank }
    its(:created_at) { should_not be_blank }
    its(:title) { should eq(attrs[:title]) }
    its(:user_id) { should eq(user.slug) }
    its(:network_id) { should eq(attrs[:network_id]) }
    its(:summary) { should be_blank }
    its(:message_ids) { should be_empty }
    its(:participant_ids) { should eq([user.slug]) }

    context 'when title is missing' do
      let(:attrs) {
        Fabricate.attributes_for(:conversation, :user => user, :title => nil) }

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
