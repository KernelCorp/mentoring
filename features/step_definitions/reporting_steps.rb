
Given /^a meeting to "(.+)" and user "(.+)" at yesterday$/ do |child_name, email|
  Meeting.create! do |meeting|
    meeting.date = DateTime.yesterday
    meeting.child_id = Child.find_by_first_name(child_name).id
    meeting.mentor_id = User.find_by_email(email).id
  end
end

Then /^I should meeting's action "(.+)" visible only meeting at yesterday$/ do |action_name|
  page.all 'table tbody tr' do |row|
    if row.have_content(Date.yesterday.strftime('%d.%m.%Y'))
      expect(row).to has_button('action_name')
    else
      expect(row).to has_no_button('action_name')
    end
  end

end
