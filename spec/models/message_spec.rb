require 'spec_helper'

describe Message do
  it { should belong_to(:user) }
  it { should belong_to(:conversation) }
  it { should belong_to(:summary) }
  it { should belong_to(:parent_message) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:replies).dependent(:destroy) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:conversation) }
  it { should validate_uniqueness_of(:slug) }

  context 'instance' do
    subject(:message) { Fabricate(:message) }

    it { should be_valid }
    its(:slug) { should eq(message.friendly_id) }

    context '#content' do
      let(:content) { Faker::HTMLIpsum.fancy_string }

      before { message.update_attributes(:content => content) }

      its(:content) { should eq(Sanitize.clean(content)) }
    end

    context '#materialize_mentions' do
      let(:conversation) { Fabricate(:conversation) }
      let(:participant) { conversation.participants.first }
      let(:content) do
        Faker::Lorem.paragraph + participant.full_name + Faker::Lorem.paragraph
      end
      subject(:message) do
        Fabricate(:message, :content => content, :conversation => conversation)
      end

      before { message.reload }

      its(:content) { should_not include(participant.full_name) }
      its(:content) { should include('@id:%d@' % participant.id) }
    end
  end
end
