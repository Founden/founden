require 'spec_helper'

describe OwnerMembership do
  it { should validate_presence_of(:network) }

  context 'instance' do
    subject(:owner_membership) { Fabricate(:network).owner_membership }

    it { should be_valid }

    context 'requires an owned network by its creator' do
      before { owner_membership.network = Fabricate(:network) }

      it { should_not be_valid }
    end
  end
end
