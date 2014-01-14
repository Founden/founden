require 'spec_helper'

feature 'Conversation timestamp attachment', :js, :slow do

  given(:user) { User.first }
  given(:timestamp) { Fabricate(:timestamp, :user => user) }
  given(:anchor) { '/conversations/%s' % timestamp.conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'details are shown' do
    expect(page).to have_content(timestamp.title)
    expect(page).to have_content(timestamp.timestamp.to_datetime.strftime('%A'))
    expect(page).to have_content(timestamp.timestamp.to_datetime.year)
    expect(page).to have_content(timestamp.timestamp.to_datetime.day)
  end

end
