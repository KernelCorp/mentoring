Given /^a user with email: "(.+)" and role "admin"$/ do |email|
  admin = User.create! do |user|
    user.email = email
    user.first_name = 'any_first_name'
    user.last_name = 'any_last_name'
    user.middle_name = 'any_middle_name'
    user.password = 'password'
  end

  admin.add_role :admin
end

Then /^admin should receive email-notification$/ do
  admin = User.with_role(:admin).first
  expect(unread_emails_for(admin.email).size).to eq(1)
end

Then /^curator should receive email-notification$/ do
  curator = User.with_role(:curator).first
  expect(unread_emails_for(curator.email).size).to eq(1)
end
