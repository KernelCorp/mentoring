When /^I go to dashboard$/ do
  visit '/activities'
end

Then /^I should see activities about new photo$/ do
  expect(page).to have_content('новую фотографию')
end

Then /^I should see activities about new book "(.+)"$/ do |book|
  expect(page).to have_content(book)
end

Then /^I should see activities about new meeting$/ do
  expect(page).to have_content('новую встречу')
end

Then /^I should see activities about new report$/ do
  expect(page).to have_content('отчёт о встрече')
end
