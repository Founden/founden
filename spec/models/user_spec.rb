require 'spec_helper'

describe User do
  it { should have_many(:identities).dependent(:destroy) }
  it { should have_many(:networks).dependent('') }
  it { should have_many(:conversations).dependent('') }
  it { should have_many(:messages).dependent('') }
  it { should have_many(:attachments).dependent('') }
  it { should have_one(:avatar).dependent(:destroy) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:slug) }

  context 'instance' do
    subject(:user) { Fabricate(:user) }

    it { should be_valid }
    its('identities.first.uid') { should include(user.email) }
    its(:email) { should_not be_empty }
    its(:first_name) { should_not be_empty }
    its(:last_name) { should_not be_empty }
    its(:slug) { should eq(user.friendly_id) }
  end
end
