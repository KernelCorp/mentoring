Given /^a orphanage "(.+)"$/ do |name|
  Orphanage.create! do |orphanage|
    orphanage.name = name
    orphanage.address = 'any address'
  end
end

Given /^a child with name "(.+)" in orphanage "(.+)"$/ do |name, orphanage|
  Child.create! do |child|
    child.first_name = name
    child.last_name = 'any_last_name'
    child.middle_name = 'any_middle_name'
    child.birthdate = 12.years.ago
    child.orphanage = Orphanage.find_by_name(orphanage)
  end
end

Given /^a user with email: "(.+)" and role "curator" for orphanage "(.+)"$/ do |email, orphanage_name|
  FactoryGirl.create :user, :curator, email: email, orphanage: Orphanage.find_by_name(orphanage_name)
end

Given /^a user with email: "(.+)" and role "mentor" for child "(.+)" and curator: "(.+)"$/ do |email, child_name, curator_email|
  curator = User.with_role(:curator).find_by_email(curator_email)
  mentor = FactoryGirl.create :user, :mentor, email: email, orphanage: curator.orphanage, curator_id: curator.id

  child = Child.where(orphanage: mentor.orphanage).find_by_first_name(child_name)
  child.update mentor_id: mentor.id
end


Given /^I signed in as user with email: "(.+)"$/ do |email|
  visit '/users/sign_in'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: 'password'
  click_button 'Войти'
end

When /^I go to "(.*)"$/ do |path|
  visit path
end

When /^I click to the button "(.+)"$/ do |button_label|
  click_on button_label
end

When /^I click on "(.+)"$/ do |label|
  click_on label
end

When /^I select child "(.+)"$/ do |child_name|
  select child_name, from: 'Ребёнок'
end

When /^I select date "tomorrow"$/ do
  fill_in 'meeting_date', with: DateTime.tomorrow
end

When /^I click to the submit button$/ do
  if page.has_css?('input[type=submit]')
    find('input[type=submit]').click
  else
    find('button[type=submit]').click
  end
end


Then /^I should see success message "(.+)"$/ do |message|
  expect(page).to have_content(message)
end

Then /^I should be redirected to new meeting"s page$/ do
  expect(current_path).to eq(meeting_path(Meeting.last))
end

Then /^a new meeting to "(.+)" at tomorrow should be created$/ do |name|
  expect(Meeting.last.child.name).to eq(name)
  expect(Meeting.last.date.to_date).to eq(Date.tomorrow)
end


Given /^a meeting to "(.+)" and user "(.+)" at tomorrow$/ do |child_name, email|
  Meeting.create! do |meeting|
    meeting.date = DateTime.tomorrow
    meeting.child_id = Child.find_by_first_name(child_name).id
    meeting.mentor_id = User.find_by_email(email).id
  end
end

Then /^the meeting should have state "(.+)"$/ do |state|
  expect(Meeting.last.state).to eq(state)
end

Then /^I should be redirected to list of meetings$/ do
  expect(current_path).to eq(meetings_path)
end

Then /^I should see only 2 meetings to "(.+)", "(.+)"$/ do |first, second|
  expect(page).to have_selector('tbody tr', text: first, count: 1)
  expect(page).to have_selector('tbody tr', text: second, count: 1)
end
