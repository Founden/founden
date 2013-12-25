require 'spec_helper'

describe Api::V1::SummariesController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:summary_ids) { [] }

    before { get(:index, :ids => summary_ids) }

    subject(:api_summaries) { json_to_ostruct(response.body) }

    its('summaries.count') { should eq(0) }

    context 'when there is a summary' do
      let(:summary) { Fabricate(:summary, :user => user) }
      let(:summary_ids) { [summary.slug] }

      its('summaries.count') { should eq(1) }
    end
  end

  describe '#show' do
    let(:summary) { Fabricate(:summary, :user => user) }
    let(:summary_id) { summary.slug }

    before { get(:show, :id => summary_id) }

    subject(:api_summary) { json_to_ostruct(response.body, :summary) }

    its('keys.size') { should eq(5) }
    its(:id) { should eq(summary.slug) }
    its(:created_at) { should eq(summary.created_at.as_json) }
    its(:network_id) { should eq(summary.network.slug) }
    its(:conversation_id) { should eq(summary.conversation.slug) }
    its(:message_ids) { should be_empty }

    context 'when summary id is not available' do
      let(:summary_id) { rand(100) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end
end
