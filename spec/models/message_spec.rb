require 'spec_helper'

describe Message do
  it { should belong_to(:user) }
  it { should belong_to(:network) }
  it { should belong_to(:conversation) }
  it { should belong_to(:summary) }
  it { should have_many(:attachments).dependent(:destroy) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:network) }
  it { should validate_presence_of(:conversation) }

  context 'instance' do
    subject(:message) { Fabricate(:message) }

    it { should be_valid }
    its(:slug) { should eq(message.friendly_id) }

    context '#content' do
      let(:content) { Faker::HTMLIpsum.fancy_string }

      before { message.update_attributes(:content => content) }

      its(:content) { should eq(Sanitize.clean(content)) }
    end
  end
end
