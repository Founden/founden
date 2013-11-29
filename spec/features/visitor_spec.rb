require 'spec_helper'

feature 'Visitor', :js, :slow do

  scenario 'is asked to sign in before accessing a non-public page' do
    visit dashboard_pages_path

    current_path.should eq(sign_in_path)
  end

  scenario 'can authenticate using a google account' do
    try_google_sign_in

    current_path.should eq(root_path)
    User.count.should eq(1)
  end

end
