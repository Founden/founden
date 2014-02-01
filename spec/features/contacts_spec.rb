require 'spec_helper'

feature 'Contacts', :js, :slowa do

  given(:user) { User.first }
  given(:friendship) do
    Fabricate(:membership, :user => user, :type => Friendship.name)
  end

  background do
    try_google_sign_in
    friendship
    visit root_path(:anchor => '/contacts')
  end

  context 'page shows the contact' do

    scenario 'details included' do
      expect(page).to have_content(friendship.creator.full_name)
    end

    context 'and clicking remove link' do
      background do
        page.find('.contacts .contact-item-actions a').click
      end

      scenario 'removes the contact' do
        wait_for_ajax
        expect(page).to_not have_content(friendship.creator.full_name)
        expect(user.friendships).to be_empty
      end

    end
  end

end
