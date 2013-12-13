require 'spec_helper'

describe PagesController do
  let(:user) { Fabricate(:user) }

  describe '#dashboard' do
    before do
      controller.stub(:current_account) { user }
      get(:dashboard)
    end

    it { should redirect_to(waiting_pages_path) }

    context 'as a user with a promo code' do
      let(:user) do
        Fabricate(:user, :promo_code => Founden::Config.promo_codes.sample)
      end
      it { should render_template(:dashboard) }
    end

    context 'as an authenticated visitor' do
      let(:user) { nil }

      it { should redirect_to(sign_in_path) }
    end
  end

  describe '#waiting' do
    before do
      controller.stub(:current_account) { user }
      get(:waiting)
    end

    it { should render_template(:waiting) }

    context 'as an authenticated visitor' do
      let(:user) { nil }

      it { should redirect_to(sign_in_path) }
    end

    context 'when a user claims a promo code' do
      let(:code) { Founden::Config.promo_codes.sample }

      before do
        post(:waiting, :user => {:promo_code => code})
      end

      it 'updates user promo code' do
        should redirect_to(root_path)
        user.promo_code.should eq(code)
      end

      context 'and it is invalid' do
        let(:code) { Faker::Lorem.word }

        it 'shows the page again' do
          should render_template(:waiting)
          user.promo_code.should be_blank
        end
      end
    end

  end
end
