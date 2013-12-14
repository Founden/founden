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

    its('keys.size') { should eq(7) }
    its(:id) { should eq(message.slug) }
    its(:created_at) { should eq(message.created_at.as_json) }
    its(:content) { should eq(message.content) }
    its(:user_id) { should eq(message.user.slug) }
    its(:network_id) { should eq(message.network.slug) }
    its(:conversation_id) { should eq(message.conversation.slug) }
    its(:attachments) { should be_empty }

    context 'when it has attachments' do
      let(:attachment) { Fabricate(:task_list, :user => user) }
      let(:message) { attachment.message }

      its('keys.size') { should eq(7) }
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

    its('keys.size') { should eq(7) }
    its(:id) { should_not be_blank }
    its(:created_at) { should_not be_blank }
    its(:content) { should eq(attrs[:content]) }
    its(:user_id) { should eq(user.slug) }
    its(:network_id) { should eq(attrs[:network_id]) }
    its(:conversation_id) { should eq(attrs[:conversation_id]) }
    its(:attachments) { should be_empty }

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
