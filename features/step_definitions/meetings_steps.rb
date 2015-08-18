
Given /^a orphanage '(.+)'$/ do |name|
  @orphanage = Orphanage.new do |orphanage|
    orphanage.name = name
    orphanage.address = 'any address'
  end
end

And /^a child with name '(.+)'$/ do |name|
  child = Child.create! do |child|
    child.first_name = name
    child.last_name = 'any_last_name'
    child.middle_name = 'any_middle_name'
    child.birthdate = 12.years.ago
    child.orphanage = @orphanage
  end
end

And /^a user with email: '(.+)' and role 'curator' for orphanage '(.+)'$/ do |email, orphanage_name|
  curator = User.create! do |user|
    user.email = email
    user.orphanage = Orphanage.find_by_name(orphanage_name)
    user.password = 'pass1234'
  end

  curator.add_role :curator
end

And /^a user with email: '(.+)' and role 'mentor' for child '(.+)' and curator: '(.+)'$/ do |email, child_name, curator_email|
  curator = User.with_role(:curator).find_by_email(curator_email)
  mentor = User.create! do |user|
    user.email = email
    user.orphanage = curator.orphanage
    user.curator_id = curator.id
    user.password = 'pass1234'
  end

  child = Child.where(orphanage: mentor.orphanage).find_by_first_name(child_name)
  child.update mentor_id: mentor.id

  mentor.add_role :mentor
end