require 'spec_helper'

feature 'Conversation link attachment', :js, :slow do

  given(:user) { User.first }
  given(:link) { Fabricate(:link, :user => user) }
  given(:anchor) { '/conversations/%s' % link.conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'details are shown' do
    expect(page).to have_content(link.url)
  end

end
