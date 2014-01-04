require 'spec_helper'

describe Invitation do
  it { should belong_to(:user) }
  it { should belong_to(:membership) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:user) }

  context 'instance' do
    let(:user) { Fabricate(:user) }

    subject(:invitation) do
      Fabricate.build(:invitation, :user => user)
    end

    it { should be_valid }

    context 'validates email exclusivity' do
      subject(:invitation) do
        Fabricate.build(:invitation, :user => user, :email => user.email)
      end

      it { should_not be_valid }

      context 'including added contact emails' do
        subject(:friendship) do
          Fabricate(:membership, :type => Friendship.name, :creator => user)
        end

        subject(:invitation) do
          Fabricate.build(
            :invitation, :user => user, :email => friendship.user.email)
        end

        it { should_not be_valid }
      end
    end

    context '#save queues an email' do
      before do
        QC.should_receive(:enqueue) do |mailer, mailer_method, invitation_id|
          mailer.should eq('UserMailer.deliver')
          mailer_method.should eq(:invite)
          invitation_id.should eq(invitation.id)
        end
        invitation.save
      end

      it { should be_valid }
    end
  end
end
