require 'spec_helper'

describe Network do
  it { should belong_to(:user) }
  it { should have_many(:conversations).dependent('') }
  it { should have_many(:messages).dependent('') }
  it { should have_many(:attachments).dependent('') }

  it { should have_one(:owner_membership).dependent(:destroy) }
  it { should have_many(:network_memberships).dependent(:destroy) }
  it { should have_many(:contacts).through(:network_memberships) }
  it { should have_many(:invitations).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(
    :title).scoped_to(:user_id).case_insensitive }
  it { should validate_presence_of(:user) }
  it { should validate_uniqueness_of(:slug) }

  context 'instance' do
    subject(:network) { Fabricate(:network) }

    it { should be_valid }
    its(:slug) { should eq(network.friendly_id) }
    its(:owner_membership) { should_not be_blank }
    its(:contacts) { should include(network.user) }

    context '#title' do
      let(:title) { Faker::HTMLIpsum.fancy_string[0..254] }

      before { network.update_attributes(:title => title) }

      its(:title) { should eq(Sanitize.clean(title)) }
    end

  end
end
