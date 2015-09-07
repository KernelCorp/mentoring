And(/^I wait "(.+)" seconds$/) do |seconds|
  sleep seconds.to_i
end

When(/^I fill in all "(.+)" inputs with "(.+)"$/) do |type, value|
  page.all("input[type=#{type}]").each do |input|
    input.set(value)
  end
end

When(/^I fill in all textarea fields with "(.+)"$/) do |value|
  page.all("textarea").each do |input|
    input.set(value)
  end
end

When(/^I select option from each select$/) do
  page.all("select").each do |select|
    within(select) do
      option = find('option:nth-child(2)').text
      select.select option
    end
  end
end

When(/^I choose each radio button with label "(.+)"$/) do |label|
  page.all(".radio_button").each do |input|
    within(input) do
      page.choose(label)
    end
  end
end

When(/^I click on agreement checkbox$/) do
  page.all(".check_box label").each do |element|
    element.click
  end
end

Then(/^I should see success message$/) do
  page.should have_css('#success')
end

Then(/^I should see disabled submit button$/) do
  expect(page).to have_button('Отправить анкету', disabled: true)
end

Given /^a new candidate$/ do
  FactoryGirl.create :candidate
end

Given /^a approved candidate$/ do
  candidate = FactoryGirl.create(:candidate, email: 'zozozoz@zozoz.com')
  candidate.approve
end

Then /^I should see (\d+) candidates$/ do |count|
  expect(page).to have_selector('tbody tr', count: count)
end

Given /^a new candidate with email: "(.+)"$/ do |email|
  FactoryGirl.create :candidate, email: email
end

Then  /^a new user with email "(.+)" with role "(.+)" should be created$/ do |email, role|
  user = User.find_by_email(email)
  expect(user).to be_present
  expect(user.has_role? role).to eq(true)
end

Then  /^the candidate with email "(.+)" should change state to "(.+)"$/ do |email, state|
  expect(Candidate.find_by_email(email).state).to eq(state)
end
