require 'spec_helper'

feature 'Invitation', :js, :slow do

  given(:anchor) { '/invitations/new' }
  given(:user) { User.first }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'shows invitation form' do
    expect(page).to have_content(user.full_name)
    expect(page).to have_css('.panel input')
    expect(page).to have_css('.panel button')
  end

  context 'filling in the invitation form' do
    given(:email) { Faker::Internet.email }

    background do
      within('.panel') do
        fill_in('email', :with => email)
      end
      page.find('.panel button').click
      wait_for_ajax
    end

    scenario 'sends the invitation and redirects to conversations' do
      expect(Invitation.first.email).to eq(email)
      expect(page.current_url).to include('#/conversations')
    end
  end

  context 'shows the invitation to be claimed' do
    given(:invitation) { Fabricate(:invitation, :email => user.email) }
    given(:anchor) { '/invitations/%s' % invitation.slug }

    scenario 'with invitation user details and confirmation link' do
      expect(page).to have_content(invitation.user.full_name)
      expect(page).to have_css('.panel button')
    end

    scenario 'and clicking confirmation shows the conversations' do
      page.find('.panel button').click
      wait_for_ajax
      expect(page.current_url).to include('#/conversations')
    end
  end

end
