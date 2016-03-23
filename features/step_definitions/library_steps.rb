When /^I select priority "(.+)"$/ do |priority|
  within '#book_priority' do
    find("option[value='#{priority}']").click
  end
end

When /^I attach some file$/ do
  attach_file('Файл', "#{Rails.root}/public/robots.txt")
end

Then /^I should be redirected to list of books$/ do
  expect(current_path).to eq(books_path)
end

Then /^a new book with title "(.+)" should be created$/ do |name|
  expect(Book.last).to be_present
  expect(Book.last.name).to eq(name)
end

Given /^a book with title: "(.+)", owner: "(.+)"$/ do |name, email|
  user = User.find_by_email(email)
  Book.create! do |book|
    book.name = name
    book.owner_id = user.id
  end
end

Then /^I should see book with title: "(.+)"$/ do |name|
  expect(page).to have_css('tbody tr td', text: name)
end

Then /^I should not see book with title: "(.+)"$/ do |name|
  expect(page).to_not have_css('tbody tr td', text: name)
end

Then /^I should not see button "(.+)"$/ do |name|
  expect(page).to_not have_css('ui.button', text: name)
end

When /^I click on book with title: "(.+)"$/ do |name|
  page.find('td a', text: name).click
end

Then /^I should see a new comment$/ do
  expect(page).to have_css('div.comments div.comment', count: 1)
end