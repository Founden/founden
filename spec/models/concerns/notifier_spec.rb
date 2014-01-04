require 'spec_helper'

describe Notifier do
  let(:message) { Fabricate(:message) }
  let(:payload) do
    [message.class.name, message.id].join(',')
  end

  describe '#notify_channels' do
    let(:channel) { 'channel_ID' }
    let(:queries) { [] }

    before do
      message.class.connection.stub(:execute) { |query| queries << query }
      message.should_receive(:notification_channels).and_return([channel])
    end
    after do
      message.class.connection.unstub(:execute)
      queries.each do |query|
        message.class.connection.execute(query)
      end
    end

    it 'triggers a notify query' do
      message.send(:notify_channels)
      queries.should include("NOTIFY %s, '%s'" % [channel, payload])
    end
  end

  describe '#payload' do
    subject { message.send(:payload) }

    it { should eq("'%s'" % payload) }
  end

  describe '#notification_channels' do
    subject { message.send(:notification_channels) }

    it { should include('user_%d' % message.user.id) }

    context 'when there are conversation participants' do
      let(:participant) { Fabricate(:user) }
      let(:conversation) { message.conversation }
      before do
        conversation.conversation_memberships.create(
          :creator => message.user, :user => participant)
      end

      it { should include('user_%d' % participant.id) }
      it { should include('user_%d' % message.user.id) }
      its(:size) { should eq(2) }
    end

  end

end
