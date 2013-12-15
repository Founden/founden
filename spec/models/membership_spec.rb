require 'spec_helper'

describe Membership do
  it { should belong_to(:creator) }
  it { should belong_to(:user) }
  it { should belong_to(:network) }
  it { should belong_to(:conversation) }

  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:user) }

  context 'instance' do
    subject(:membership) { Fabricate(:membership) }

    it { should be_valid }
    its(:slug) { should eq(membership.friendly_id) }
  end
end
