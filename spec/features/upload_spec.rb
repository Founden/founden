require 'spec_helper'

feature 'Conversation upload attachment', :js, :slow do

  given(:user) { User.first }
  given(:upload) { Fabricate(:upload, :user => user) }
  given(:anchor) { '/conversations/%s' % upload.conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'details are shown' do
    expect(page).to have_content(upload.title)
    expect(page.source).to include(upload.attachment.url(:small))
  end

end
