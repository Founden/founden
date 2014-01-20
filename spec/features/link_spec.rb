require 'spec_helper'

feature 'Conversation link attachment', :js, :slow do

  given(:user) { User.first }
  given(:link) { Fabricate(:link, :user => user) }
  given(:conversation) { link.conversation }
  given(:anchor) { '/conversations/%s' % conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'details are shown' do
    expect(page).to have_content(link.url)
  end

  context 'is available to add' do
    given(:conversation) { Fabricate(:conversation, :user => user) }
    given(:content) { Faker::Lorem.sentence }

    background do
      page.find('.message-form-input').click
      page.all('.caret-actions span').last.click
      page.find('.attachment-options .link').click
    end

    scenario 'filling attachment editor saves it' do
      page.fill_in('message', :with => content)
      page.fill_in('link', :with => 'http://google.ro')
      page.find('.message-form-actions button').trigger('click')
      wait_for_ajax

      expect(page).to have_content(content)
      expect(page).to have_content('google.ro')
    end

  end

end
