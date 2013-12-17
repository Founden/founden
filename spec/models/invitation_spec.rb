require 'spec_helper'

describe Invitation do
  it { should belong_to(:user) }
  it { should belong_to(:network) }
  it { should belong_to(:membership) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:network) }

  context 'instance' do
    subject(:invitation) { Fabricate.build(:invitation) }

    it { should be_valid }

  end
end
