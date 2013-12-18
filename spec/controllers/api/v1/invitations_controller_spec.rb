require 'spec_helper'

describe Api::V1::InvitationsController do
  let(:user) { Fabricate(:user) }

  before do
    controller.stub(:current_account) { user }
  end

  describe '#index' do
    let(:invitation_ids) { [] }
    before { get(:index, :ids => invitation_ids) }

    subject(:api_invitations) { json_to_ostruct(response.body) }

    its('invitations.count') { should eq(0) }

    context 'when a valid invitation ID is queried' do
      let(:invitation) { Fabricate(:invitation, :user => user) }
      let(:invitation_ids) { [invitation.slug] }

      its('invitations.count') { should eq(1) }
      its('invitations.first.values.first') { should eq(invitation.slug) }
    end
  end

  describe '#show' do
    let(:invitation) { Fabricate(:invitation, :email => user.email) }
    let(:invitation_id) { invitation.slug }
    before { get(:show, :id => invitation_id) }

    subject(:api_invitation) { json_to_ostruct(response.body, :invitation) }

    its('keys.count') { should eq(5) }
    its(:id) { should eq(invitation.slug) }
    its(:created_at) { should eq(invitation.created_at.as_json) }
    its(:network_title) { should eq(invitation.network.title) }
    its(:membership_id) { should be_blank }
    its(:user_id) { should eq(invitation.user.slug) }

    context 'when an invalid invitation ID is queried' do
      let(:invitation_id) { '-' }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end

    context 'when invitation is not available' do
      let(:invitation) { Fabricate(:invitation) }

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include(_('Resource unavailable')) }
    end
  end

  describe '#create' do
    let(:attrs) do
      Fabricate.attributes_for(
        :invitation, :user => user, :network => user.networks.first)
    end
    before { post(:create, :invitation => attrs) }

    subject(:api_invitation) { json_to_ostruct(response.body, :invitation) }

    its('keys.count') { should eq(7) }
    its(:id) { should_not be_blank }
    its(:created_at) { should_not be_blank }
    its(:network_id) { should eq(attrs[:network_id]) }
    its(:network_title) { should_not be_blank }
    its(:membership_id) { should be_blank }
    its(:user_id) { should eq(user.slug) }
    its(:email) { should eq(attrs[:email]) }

    context 'when email is unavailable' do
      let(:attrs) do
        Fabricate.attributes_for(:invitation, :user => user, :email => '',
          :network => user.networks.first)
      end

      subject { response }

      its(:status) { should eq(400) }
      its(:body) { should include("Email can't be blank") }
    end

    context 'when network reference is unavailable' do
      let(:attrs) do
      Fabricate.attributes_for(
        :invitation, :user => user, :network_id => '-')
      end

      subject { response }

      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end
  end

  describe '#update' do
    let(:invitation) do
      Fabricate(:invitation, :email => user.email)
    end
    let(:invitation_id) { invitation.slug }

    before { patch(:update, :id => invitation_id) }

    subject(:api_invitation) { json_to_ostruct(response.body, :invitation) }

    its('keys.count') { should eq(7) }
    its(:id) { should eq(invitation.slug) }
    its(:email) { should eq(user.email) }
    its(:created_at) { should eq(invitation.created_at.as_json) }
    its(:network_id) { should eq(invitation.network.slug) }
    its(:network_title) { should eq(invitation.network.title) }
    its(:membership_id) { should eq(invitation.reload.membership.slug) }
    its(:user_id) { should eq(invitation.user.slug) }

    context 'when email is wrong' do
      let(:invitation) do
        Fabricate(:invitation)
      end

      subject { response }
      its(:status) { should eq(404) }
      its(:body) { should include('Resource unavailable') }
    end

    context 'when invitation is claimed already' do
      let(:membership) { user.networks.first.network_memberships.first }
      let(:invitation) do
        Fabricate(:invitation, :email => user.email, :membership => membership)
      end

      its('keys.count') { should eq(5) }
      its(:id) { should eq(invitation.slug) }
      its(:created_at) { should eq(invitation.created_at.as_json) }
      its(:network_title) { should eq(invitation.network.title) }
      its(:membership_id) { should eq(membership.slug) }
      its(:user_id) { should eq(invitation.user.slug) }
    end
  end
end
