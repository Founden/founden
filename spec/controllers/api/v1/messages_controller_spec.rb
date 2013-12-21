require 'spec_helper'

describe Api::V1::MessagesController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:message_ids) { user.messages.map(&:slug) }

    before { get(:index, :ids => message_ids) }

    subject(:api_messages) { json_to_ostruct(response.body) }

    its('messages.count') { should eq(0) }

    context 'when current user has messages' do
      let(:message_ids) { [Fabricate(:message, :user => user).slug] }

      its('messages.count') { should eq(1) }
    end
  end

  describe '#show' do
    let(:message) { Fabricate(:message, :user => user) }
    let(:message_id) { message.slug }

    before { get(:show, :id => message_id) }

    subject(:api_message) { json_to_ostruct(response.body, :message) }

    its('keys.size') { should eq(9) }
    its(:id) { should eq(message.slug) }
    its(:created_at) { should eq(message.created_at.as_json) }
    its(:content) { should eq(message.content) }
    its(:user_id) { should eq(message.user.slug) }
    its(:network_id) { should eq(message.network.slug) }
    its(:conversation_id) { should eq(message.conversation.slug) }
    its(:parent_message_id) { should be_blank }
    its(:reply_ids) { should be_empty }
    its(:attachments) { should be_empty }

    context 'when it has replies' do
      let(:parent_message) { Fabricate(:message, :user => user) }
      let(:message) do
        Fabricate(:message, :user => user, :network => parent_message.network,
          :conversation => parent_message.conversation,
          :parent_message => parent_message
        )
      end
      let(:message_id) { message.parent_message.slug }

      its('keys.size') { should eq(9) }
      its('reply_ids.size') { should eq(1) }
      its(:reply_ids) { should include(message.slug) }
    end

    context 'when it has attachments' do
      let(:attachment) { Fabricate(:task_list, :user => user) }
      let(:message) { attachment.message }

      its('keys.size') { should eq(9) }
      its('attachments.length') { should eq(1) }
      its('attachments.first.keys.sort') { should eq(%w(type id).sort) }
      its('attachments.first.values.sort') { should eq(
        [attachment.slug, attachment.type.to_s.underscore].sort) }
    end

    context 'when network id is not available' do
      let(:message_id) { rand(100) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

  describe '#create' do
    let(:attrs) { Fabricate.attributes_for(:message, :user => user) }

    before { post(:create, :message => attrs) }

    subject(:api_message) { json_to_ostruct(response.body, :message) }

    its('keys.size') { should eq(9) }
    its(:id) { should_not be_blank }
    its(:created_at) { should_not be_blank }
    its(:content) { should eq(attrs[:content]) }
    its(:user_id) { should eq(user.slug) }
    its(:network_id) { should eq(attrs[:network_id]) }
    its(:conversation_id) { should eq(attrs[:conversation_id]) }
    its(:parent_message_id) { should be_blank }
    its(:attachments) { should be_empty }
    its(:reply_ids) { should be_empty }

    context 'when parent message ID is set' do
      let(:parent_message) { Fabricate(:message, :user => user) }
      let(:attrs) do
        Fabricate.attributes_for(
          :message, :user => user, :network => parent_message.network,
          :conversation => parent_message.conversation,
          :parent_message => parent_message
        )
      end

      its('keys.size') { should eq(9) }
      its(:parent_message_id) { should eq(attrs[:parent_message_id]) }

      context 'and it is invalid' do
        let(:attrs) do
          Fabricate.attributes_for(
            :message, :user => user, :parent_message_id => '-')
        end

        subject { response }

        its(:status) { should eq(404) }
        its(:body) { should include(_('Resource unavailable')) }
      end
    end

    context 'when content is missing' do
      let(:attrs) {
        Fabricate.attributes_for(:message, :user => user, :content => nil) }

      subject { response }

      its(:status) { should eq(400) }
      its(:body) { should include("Content can't be blank") }
    end

    context 'when network id is not available' do
      let(:attrs) { Fabricate.attributes_for(:message, :network_id => 0) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end

    context 'when conversation id is not available' do
      let(:attrs) { Fabricate.attributes_for(:message, :conversation_id => 0) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

end
