require 'spec_helper'

feature 'Conversation timestamp attachment', :js, :slow do

  given(:user) { User.first }
  given(:timestamp) { Fabricate(:timestamp, :user => user) }
  given(:conversation) { timestamp.conversation }
  given(:anchor) { '/conversations/%s' % conversation.slug }

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

  context 'is available to add' do
    given(:conversation) { Fabricate(:conversation, :user => user) }
    given(:title) { Faker::Lorem.sentence }
    given(:content) { Faker::Lorem.sentence }

    background do
      page.find('.message-form-input').click
      page.all('.caret-actions span').last.click
      page.find('.attachment-options .timestamp').click
    end

    scenario 'filling attachment editor saves it' do
      page.fill_in('message', :with => content)
      page.find('.attachments-editor .enable-title').trigger('click')
      page.fill_in('timestamp', :with => '29 August 1987')
      page.fill_in('title', :with => title)
      page.find('.message-form-actions button').trigger('click')
      wait_for_ajax

      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content('29th August, 1987')
    end

  end

end
