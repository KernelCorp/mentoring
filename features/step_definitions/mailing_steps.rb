When /^I select destination "(.+)"$/ do |user_email|
  expect(current_path).to eq(new_conversation_path)
  select user_email, from: 'Получатели'
end

Then /^a new conversation with "(.+)" should be created$/ do |email|
  last_conversation =  Mailboxer::Conversation.last
  expect(User.find_by_email(email).mailbox.conversations.last).to be_present
  expect(last_conversation.recipients.map(&:email)).to include(email)
end

Then /^I should be redirected to new conversation page$/ do
  expect(current_path).to eq(conversation_path(Mailboxer::Conversation.last))
end

Then /^I should see only (\d+) conversation with originator "(.+)"$/ do |count, email|
  expect(page).to have_selector('div.message', text: email, count: count)
end

Given /^a conversation with originator "(.+)" and recipient "(.+)"$/ do |sender_email, recipient_email|
  originator = User.find_by_email(sender_email)
  recipient = User.find_by_email(recipient_email)

  originator.send_message(recipient, 'body', 'subject')
end

When /^I should see only (\d+) messages on this page$/ do |count|
  expect(page).to have_selector('div.message', count: count)
end

When /^a conversation with "(.+)" should have only (\d+) messages$/ do |email, count|
  mailbox = User.find_by_email(email).mailbox
  conversation = mailbox.conversations.last
  expect(conversation.messages.count).to eq(count.to_i)
end