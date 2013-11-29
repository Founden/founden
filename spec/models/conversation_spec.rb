require 'spec_helper'

describe Conversation do
  it { should belong_to(:user) }
  it { should belong_to(:network) }

  it { should validate_presence_of(:title) }

  context 'instance' do
    subject(:conversation) { Fabricate(:conversation) }

    it { should be_valid }
    its(:slug) { should eq(conversation.friendly_id) }
  end
end
