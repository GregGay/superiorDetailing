require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, firstname: "Gary", email: "gary@example.com")
      FactoryGirl.create(:user, firstname: "John", email: "john@example.com")
      visit users_path
    end

    it { should have_selector('title', text: 'All Users') }
    it { should have_selector('h1',    text: 'All Users') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.firstname, test: user.lastname)
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.firstname) }
    it { should have_selector('h1',    text: user.lastname) }
    it { should have_selector('title', text: user.firstname) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do

      before do
        fill_in "Firstname",     with: "Example"
        fill_in "Lastname",      with: "User"
        fill_in "Email",         with: "user@example.com"
        fill_in "Streetaddress", with: "1 example users drive"
        fill_in "City",  		     with: "asheville"
        fill_in "State",   		   with: "nc"
        fill_in "Zip",			     with: "28787"
        fill_in "Phone", 		     with: "1234567890"
        fill_in "Password",      with: "secure"
        fill_in "Confirmation",  with: "secure"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    #before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_firstname)  { "New" }
      let(:new_lastname)  { "Name" }
      let(:new_email) { "new@example.com" }
      let(:new_streetaddress)  { "3 Example Street" }
      let(:new_city)  { "Waterbury" }
      let(:new_state)  { "ct" }
      let(:new_zip)  { "78782" }
      let(:new_phone)  { "0987654321" }

      before do
        fill_in "Firstname",        with: new_firstname
        fill_in "Lastname",         with: new_lastname
        fill_in "Email",            with: new_email
        fill_in "Streetaddress",    with: new_streetaddress
        fill_in "City",             with: new_city
        fill_in "State",            with: new_state
        fill_in "Zip",              with: new_zip
        fill_in "Phone",            with: new_phone
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_firstname) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.firstname.should  == new_firstname }
      specify { user.reload.email.should == new_email }
    end
  end
end