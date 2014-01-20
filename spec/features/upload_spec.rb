require 'spec_helper'

feature 'Conversation upload attachment', :js, :slow do

  given(:user) { User.first }
  given(:upload) { Fabricate(:upload, :user => user) }
  given(:conversation) { upload.conversation }
  given(:anchor) { '/conversations/%s' % conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'details are shown' do
    expect(page).to have_content(upload.title)
    expect(page.source).to include(upload.attachment.url(:small))
  end

  context 'is available to add' do
    given(:conversation) { Fabricate(:conversation, :user => user) }
    given(:content) { Faker::Lorem.sentence }
    given(:image_path) { Rails.root.join('spec/fixtures/test.png') }

    background do
      page.find('.message-form-input').click
      page.all('.caret-actions span').last.click
      page.find('.attachment-options .upload').click
    end

    scenario 'filling attachment editor saves it' do
      page.fill_in('message', :with => content)

      expect(page).to have_css('.attachment-uploader .uploader-drop-area')

      attach_file('image', image_path)
      page.find('.message-form-actions button').trigger('click')
      wait_for_ajax

      expect(page).to_not have_css('.attachment-uploader .uploader-drop-area')
      expect(page).to have_content(content)
      expect(page).to have_css('.attachments .attachment-file', :count => 1)
    end

  end
end
