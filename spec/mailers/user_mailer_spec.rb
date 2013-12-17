require 'spec_helper'

describe UserMailer do
  require_relative 'shared'

  let(:user) { Fabricate(:user) }

  subject(:email) { ActionMailer::Base.deliveries.last }

  before(:each) { ActionMailer::Base.deliveries.clear }

  describe '#invite' do
    let(:some_email) { Faker::Internet.email }

    before do
      UserMailer.deliver(:invite, some_email, user)
    end

    it_should_behave_like 'an email from us'
    its('body.encoded') { should include(user.full_name) }
    its('body.encoded') { should include(root_url) }
    its(:to) { should include(some_email) }
  end

end
