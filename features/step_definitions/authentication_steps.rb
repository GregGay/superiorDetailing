Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button "Sign in"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = User.create(firstname: "Example", lastname: "User", 
    email: "user@example.com", streetaddress: "1 example users drive", 
    city: "asheville", state: "nc", zip: "28803", phone: "1234567890",
    password: "secure", password_confirmation: "secure")
end

When /^the user submits valid signin information$/ do
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password 
  click_button "Sign in"
end

Then /^he should see his profile page$/ do
  page.should have_selector('title', text: @user.firstname)
end

Then /^he should see a signout link$/ do
  page.should have_link('Sign out', href: signout_path)
end