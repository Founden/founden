require 'spec_helper'

feature 'Conversation task list attachment', :js, :slow do

  given(:user) { User.first }
  given(:task_list) { Fabricate(:task_list, :user => user) }
  given(:anchor) { '/conversations/%s' % task_list.conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'tasks are shown' do
    task_list.tasks.each do |task|
      expect(page).to have_content(task[:label])
    end
  end

  scenario 'tasks can be checked' do
    page.all('.attachment-tasks li').each do |task|
      task.click unless task[:css].blank?
    end

    expect(page).to have_css(
      '.attachment-tasks li.checked', :count => task_list.tasks.count)
  end

end
