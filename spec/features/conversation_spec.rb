require 'spec_helper'

feature 'Conversation', :js, :slow do

  given(:user) { User.first }
  given(:conversation) { Fabricate(:conversation, :user => user) }
  given(:anchor) { '/conversations' % conversation }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'can be started from dashboard' do
    expect(Conversation.count).to eq(1)

    page.find('.navbar-main-action .button').click
    fill_in('title', :with => Faker::Lorem.sentence)
    page.find('.conversation-create-btn').click
    wait_for_ajax

    expect(Conversation.count).to eq(2)
    expect(page.current_url).to include(
      '/conversations/%s' % Conversation.last.slug)
  end

  scenario 'can be accessed from dashboard' do
    expect(page).to have_content(conversation.title)

    page.find('.conversation-%s' % conversation.slug).click
    expect(page.current_url).to include('/conversations/%s' % conversation.slug)
  end

  context 'page shows the messages' do
    given(:message) do
      Fabricate(:message, :user => user, :conversation => conversation)
    end
    given(:anchor) { '/conversations/%s' % message.conversation.slug }

    scenario 'message details are included' do
      expect(page).to have_content(message.content)
    end
  end

  context 'message form' do
    given(:content) do
      Faker::Lorem.sentence
    end
    given(:anchor) { '/conversations/%s' % conversation.slug }

    scenario 'submission creates a new message' do
      fill_in('message', :with => content)
      find('.message-form-actions button').click
      wait_for_ajax

      expect(page).to have_content(content)
    end
  end

end
