require 'spec_helper'

feature 'Conversation task list attachment', :js, :slow do

  given(:user) { User.first }
  given(:task_list) { Fabricate(:task_list, :user => user) }
  given(:conversation) { task_list.conversation }
  given(:anchor) { '/conversations/%s' % conversation.slug }

  background do
    try_google_sign_in
    visit root_path(:anchor => anchor)
  end

  scenario 'tasks are shown' do
    expect(page).to have_content(task_list.title)
    task_list.tasks.each do |task|
      expect(page).to have_content(task[:label])
    end
  end

  scenario 'tasks can be checked' do
    page.all('.attachment-tasks li.checked').each do |task|
      task.click
    end

    expect(page).to have_css('.attachment-tasks li.checked', :count => 0)
    wait_for_ajax

    tasks = task_list.reload.tasks.collect do |task|
      task if task['checked']
    end

    expect(tasks.compact.count).to eq(0)
  end

  context 'is available to add' do
    given(:conversation) { Fabricate(:conversation, :user => user) }
    given(:title) { Faker::Lorem.sentence }
    given(:content) { Faker::Lorem.sentence }

    background do
      page.find('.message-form-input').click
      page.all('.caret-actions span').last.click
      page.find('.attachment-options .tasklist').click
    end

    scenario 'filling attachment editor saves it' do
      page.fill_in('message', :with => content)
      page.find('.attachments-editor .enable-title').trigger('click')
      page.fill_in('title', :with => title)

      page.fill_in('task', :with => 'Task 1')
      page.find_field('task').native.send_key(:Enter)
      page.find('.attachment-tasks li label').click

      page.fill_in('task', :with => 'Task 2')
      page.find_field('task').native.send_key(:Enter)

      page.find('.message-form-actions button').trigger('click')
      wait_for_ajax

      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content('Task 1')
      expect(page).to have_content('Task 2')
      expect(page).to have_css('.attachment-tasks li.checked', :count => 1)
    end

  end
end
