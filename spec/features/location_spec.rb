require 'spec_helper'

feature 'Conversation location attachment', :js, :slow do

  given(:user) { User.first }
  given(:location) { Fabricate(:location, :user => user) }
  given(:anchor) { '/conversations/%s' % location.conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'map is shown' do
    expect(page).to have_content(location.title)
    expect(page).to have_css('.attachment-location .location-map')
  end

end
