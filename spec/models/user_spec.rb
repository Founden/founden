require 'spec_helper'

describe User do
  it { should have_many(:identities).dependent(:destroy) }

  it { should have_many(:created_networks).dependent('') }
  it { should have_many(:network_memberships).dependent(:destroy) }
  it { should have_many(:shared_networks).through(:network_memberships) }
  it { should have_many(:memberships).dependent(:destroy) }
  it { should have_many(:networks).through(:memberships) }

  it { should have_many(:created_conversations).dependent('') }
  it { should have_many(:conversation_memberships).dependent(:destroy) }
  it { should have_many(:conversations).through(:conversation_memberships) }

  it { should have_many(:messages).dependent('') }
  it { should have_many(:attachments).dependent('') }
  it { should have_one(:avatar).dependent(:destroy) }
  it { should have_many(:invitations).dependent(:destroy) }

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
    its(:full_name) { should eq('%s %s' % [user.first_name, user.last_name]) }

    context '#networks' do
      subject { user.networks }

      its(:length) { should eq(1) }
      its('first.title') { should eq(_('%s Network') % user.full_name) }
    end

  end
end
