When /^I click to the link "(.+)"$/ do |name|
  click_link(name)
end

Then /^a new album should be created$/ do
  expect(Album.last).to be_present
end

Then /^I should be redirected to the album's page$/ do
  expect(current_path).to eq(album_path(Album.last))
end

Given /^user "(.+)" has album "(.+)"$/ do |email, album_name|
  user = User.find_by_email(email)
  user.albums.create! do |album|
    album.title = album_name
    album.description = 'description'
  end
end

When /^I go to page of user "(.+)"$/ do |email|
  visit user_path(User.find_by_email(email))
end

Then /^I should see album "(.+)"$/ do |album|
  expect(page).to have_css('div.ui.list', text: album)
end
