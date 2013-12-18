require 'spec_helper'

describe UserMailer do
  require_relative 'shared'

  let(:user) { Fabricate(:user) }

  subject(:email) { ActionMailer::Base.deliveries.last }

  before(:each) { ActionMailer::Base.deliveries.clear }

  describe '#invite' do
    let(:invitation) { Fabricate(:invitation, :email => user.email) }

    before do
      UserMailer.deliver(:invite, invitation.id)
    end

    it_should_behave_like 'an email from us'
    its('body.encoded') { should include(invitation.user.full_name) }
    its('body.encoded') { should include(
      root_url(:anchor => '/invitations/%s' % invitation.slug)) }
    its(:to) { should include(invitation.email) }
  end

end
