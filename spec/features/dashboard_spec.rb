require 'spec_helper'

feature 'Dashboard', :js, :slow do

  background do
    try_google_sign_in
    visit root_path
  end

  scenario 'shows no conversations' do
    expect(page).to have_css('.conversations .conversation-item', :count => 0)
  end

  context 'when user has conversations' do
    background do
      Fabricate(:conversation, :user => User.first)
      visit root_path
    end

    scenario 'shows latest conversations' do
      expect(page).to have_css('.conversations .conversation-item', :count => 1)
    end
  end

end
