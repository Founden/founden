require 'spec_helper'

feature 'Conversation location attachment', :js, :slow do

  given(:user) { User.first }
  given(:location) { Fabricate(:location, :user => user) }
  given(:conversation) { location.conversation }
  given(:anchor) { '/conversations/%s' % conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'map is shown' do
    expect(page).to have_content(location.title)
    expect(page).to have_css('.attachment-location .location-map')
  end

  context 'is available to add' do
    given(:conversation) { Fabricate(:conversation, :user => user) }
    given(:title) { Faker::Lorem.sentence }
    given(:content) { Faker::Lorem.sentence }

    background do
      page.find('.message-form-input').click
      page.all('.caret-actions span').last.click
      page.find('.attachment-options .location').click
    end

    scenario 'filling attachment editor saves it' do
      page.fill_in('message', :with => content)
      page.find('.attachments-editor .enable-title').trigger('click')
      page.fill_in('location', :with => 'Cluj, Romania')
      sleep(1) # Wait map to load
      page.fill_in('title', :with => title)
      page.find('.message-form-actions button').trigger('click')
      wait_for_ajax

      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_css('.attachment-location .location-map')
    end

  end

end
