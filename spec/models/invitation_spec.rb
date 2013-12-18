require 'spec_helper'

describe Invitation do
  it { should belong_to(:user) }
  it { should belong_to(:network) }
  it { should belong_to(:membership) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:network) }

  context 'instance' do
    let(:user) { Fabricate(:user) }
    let(:network) { user.networks.first }

    subject(:invitation) do
      Fabricate.build(:invitation, :user => user, :network => network)
    end

    it { should be_valid }
    its(:invitee) { should be_nil }

    context 'when the email is registered' do
      let(:registered_email_user) {Fabricate(:user, :email => invitation.email)}

      before { registered_email_user }

      its(:invitee) { should eq(registered_email_user) }
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
