require 'spec_helper'

describe Api::V1::AttachmentsController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:attachment_ids) { user.attachments.map(&:slug) }

    before { get(:index, :ids => attachment_ids) }

    subject(:api_attachments) { json_to_ostruct(response.body) }

    its('attachments.count') { should eq(0) }

    context 'when current user has attchments' do
      let(:attachment_ids) { [Fabricate(:timestamp, :user => user).slug] }

      its('attachments.count') { should eq(1) }
    end
  end

  describe '#show' do
    let(:attachment_id) { }

    before { get(:show, :id => attachment_id) }

    shared_examples_for 'an attachment' do
      its(:id) { should eq(attachment.slug) }
      its(:created_at) { should eq(attachment.created_at.as_json) }
      its(:type) { should eq(attachment.type.to_s.underscore) }
      its(:title) { should eq(attachment.title) }
      its(:user_id) { should eq(attachment.user.slug) }
      its(:conversation_id) { should eq(attachment.conversation.slug) }
      its(:message_id) { should eq(attachment.message.slug) }
    end

    context 'for an avatar attachment' do
      let(:attachment) { Fabricate(:avatar, :user => user) }
      let(:attachment_id) { attachment.slug }

      subject(:api_avatar) { json_to_ostruct(response.body, :avatar) }

      its('keys.size') { should eq(9) }
      its(:id) { should eq(attachment.slug) }
      its(:created_at) { should eq(attachment.created_at.as_json) }
      its(:type) { should eq(attachment.type.to_s.underscore) }
      its(:title) { should be_blank }
      its(:user_id) { should eq(attachment.user.slug) }
      its(:attachment) { should eq(attachment.attachment.to_s) }
      its(:thumb_size_url) { should eq(attachment.attachment.url(:thumb)) }
      its(:small_size_url) { should eq(attachment.attachment.url(:small)) }
      its(:medium_size_url) { should eq(attachment.attachment.url(:medium)) }
    end

    context 'for a link attachment' do
      let(:attachment) { Fabricate(:link, :user => user) }
      let(:attachment_id) { attachment.slug }

      subject(:api_link) { json_to_ostruct(response.body, :link) }

      its('keys.size') { should eq(8) }
      its(:url) { should eq(attachment.url) }
      it_behaves_like 'an attachment'
    end

    context 'for a location attachment' do
      let(:attachment) { Fabricate(:location, :user => user) }
      let(:attachment_id) { attachment.slug }

      subject(:api_location) { json_to_ostruct(response.body, :location) }

      its('keys.size') { should eq(9) }
      its(:latitude) { should eq(attachment.latitude.to_s) }
      its(:longitude) { should eq(attachment.longitude.to_s) }
      it_behaves_like 'an attachment'
    end

    context 'for a task list attachment' do
      let(:attachment) { Fabricate(:task_list, :user => user) }
      let(:attachment_id) { attachment.slug }

      subject(:api_task_list) { json_to_ostruct(response.body, :task_list) }

      its('keys.size') { should eq(8) }
      its('tasks.length') { should eq(attachment.tasks.length) }
      its('tasks.first.keys') { should eq(attachment.tasks.first.keys) }
      its('tasks.first.values') { should eq(attachment.tasks.first.values) }
      it_behaves_like 'an attachment'
    end

    context 'for a timestamp attachment' do
      let(:attachment) { Fabricate(:timestamp, :user => user) }
      let(:attachment_id) { attachment.slug }

      subject(:api_timestamp) { json_to_ostruct(response.body, :timestamp) }

      its('keys.size') { should eq(8) }
      its(:timestamp) { should eq(attachment.timestamp.to_s) }
      it_behaves_like 'an attachment'
    end

    context 'for an upload attachment' do
      let(:attachment) { Fabricate(:upload, :user => user) }
      let(:attachment_id) { attachment.slug }

      subject(:api_upload) { json_to_ostruct(response.body, :upload) }

      its('keys.size') { should eq(13) }
      its(:attachment) { should eq(attachment.attachment.to_s) }
      its(:attachment_file_size) { should eq(attachment.attachment_file_size) }
      its(:attachment_file_name) { should eq(attachment.attachment_file_name) }
      its(:thumb_size_url) { should eq(attachment.attachment.url(:thumb)) }
      its(:small_size_url) { should eq(attachment.attachment.url(:small)) }
      its(:medium_size_url) { should eq(attachment.attachment.url(:medium)) }
      it_behaves_like 'an attachment'
    end

    context 'when attachment id is not available' do
      let(:attachment_id) { rand(100) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

  describe '#create' do
    let(:attachment_type) { }
    let(:attrs) { Fabricate.attributes_for(attachment_type, :user => user) }

    before { post(:create, attachment_type => attrs) }

    subject(:api_attachment) { json_to_ostruct(response.body, attachment_type) }

    context 'for a timestamp attachment type' do
      let(:attachment_type) { :timestamp }

      its('keys.size') { should eq(8) }
      its(:id) { should_not be_blank }
      its(:created_at) { should_not be_blank }
      its(:type) { should eq(attachment_type.to_s) }
      its(:title) { should eq(attrs[:title]) }
      its(:timestamp) { should eq(attrs[:timestamp]) }
      its(:user_id) { should eq(user.slug) }
      its(:conversation_id) { should eq(attrs[:conversation_id]) }
      its(:message_id) { should eq(attrs[:message_id]) }
    end

    context 'for a location attachment type' do
      let(:attachment_type) { :location }

      its('keys.size') { should eq(9) }
      its(:id) { should_not be_blank }
      its(:created_at) { should_not be_blank }
      its(:type) { should eq(attachment_type.to_s) }
      its(:title) { should eq(attrs[:title]) }
      its(:longitude) { should eq(attrs[:longitude].to_s) }
      its(:latitude) { should eq(attrs[:latitude].to_s) }
      its(:user_id) { should eq(user.slug) }
      its(:conversation_id) { should eq(attrs[:conversation_id]) }
      its(:message_id) { should eq(attrs[:message_id]) }
    end

    context 'when root key is not available' do
      let(:attachment_type) { :some_key }
      let(:attrs) { Fabricate.attributes_for(:timestamp) }

      subject { response }

      its(:status) { should eq(400) }
      its(:body) { should include(_('We were expecting a different input')) }
    end
  end

end
