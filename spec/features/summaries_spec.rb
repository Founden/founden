require 'spec_helper'

feature 'Summary', :js, :aslow do

  given(:user) { User.first }
  given(:summary) { Fabricate(:summary, :user => user) }
  given(:anchor) { '/summaries' % summary }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'can be accessed from the listing page' do
    expect(page).to have_content(summary.conversation.title)

    page.find('.summary-%s' % summary.slug).click
    expect(page.current_url).to include('/summaries/%s' % summary.slug)
  end

  context 'from the conversation page' do
    let(:anchor) { '/conversations/%s' % summary.conversation.slug }

    scenario 'summary is also available' do
      page.find('.conversation-summary-btn').click

      expect(page).to have_content(summary.conversation.title)
      expect(page.current_url).to include('/summaries/%s' % summary.slug)
    end
  end

  context 'page shows the messages' do
    given(:message) do
      Fabricate(:message, :user => user,
                :conversation => summary.conversation, :summary => summary)
    end
    given(:anchor) { '/summaries/%s' % message.summary.slug }

    scenario 'message details are included' do
      expect(page).to have_content(message.content)
    end
  end

end
