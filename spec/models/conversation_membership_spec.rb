require 'spec_helper'

describe ConversationMembership do
  it { should validate_presence_of(:network) }
  it { should validate_presence_of(:conversation) }

  context 'instance' do
    subject(:conversation_membership) do
      Fabricate(:conversation).conversation_memberships.first
    end

    it { should be_valid }

    context 'requires the same network conversation has' do
      before { conversation_membership.network = Fabricate(:network) }

      it { should_not be_valid }
    end

    context 'requires a conversation owned/shared by the creator' do
      before { conversation_membership.conversation = Fabricate(:conversation) }

      it { should_not be_valid }
    end

    context 'requires the creator to be an existent participant' do
      before { conversation_membership.conversation = Fabricate(:conversation) }

      it { should_not be_valid }
    end
  end
end
