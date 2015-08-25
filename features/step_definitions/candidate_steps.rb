And(/^I wait "(.+)" seconds$/) do |seconds|
  sleep seconds.to_i
end

And(/^I fill in all "(.+)" inputs with "(.+)"$/) do |type, value|
  page.all("input[type=#{type}]").each do |input|
    input.set(value)
  end
end

And(/^I fill in all textarea fields with "(.+)"$/) do |value|
  page.all("textarea").each do |input|
    input.set(value)
  end
end

And(/^I select option from each select$/) do
  page.all("select").each do |select|
    within(select) do
      option = find('option:nth-child(2)').text
      select.select option
    end
  end
end

And(/^I choose each radio button with label "(.+)"$/) do |label|
  page.all(".radio_button").each do |input|
    within(input) do
      page.choose(label)
    end
  end
end

And(/^I click on agreement checkbox$/) do
  page.find(".check_box label").click
end

Then(/^I should see success message$/) do
  page.should have_css('#success')
end

Then(/^I should see disabled submit button$/) do
  expect(page).to have_button('Отправить анкету', disabled: true)
end