require 'spec_helper'

describe Conversation do
  it { should belong_to(:user) }
  it { should belong_to(:network) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:network) }
  it { should validate_presence_of(:user) }

  context 'instance' do
    subject(:conversation) { Fabricate(:conversation) }

    it { should be_valid }
    its(:slug) { should eq(conversation.friendly_id) }

    context '#title' do
      let(:title) { Faker::HTMLIpsum.fancy_string[0..254] }

      before { conversation.update_attributes(:title => title) }

      its(:title) { should eq(Sanitize.clean(title)) }
    end
  end
end
