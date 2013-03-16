# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  firstname     :string(255)
#  lastname      :string(255)
#  email         :string(255)
#  streetaddress :string(255)
#  city          :string(255)
#  state         :string(255)
#  zip           :string(255)
#  phone         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(firstname: "Example", lastname: "User", 
    email: "user@example.com", streetaddress: "1 example users drive", 
    city: "asheville", state: "nc", zip: "28803", phone: "1234567890",
    password: "secure", password_confirmation: "secure") }

  subject { @user }

  it { should respond_to(:firstname) }  
  it { should respond_to(:lastname) }
  it { should respond_to(:email) }
  it { should respond_to(:streetaddress) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:phone) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }  

  it { should be_valid }
  it { should_not be_admin }

######ADMINISTRATIVE USERS######

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

######PRESENCE######

  describe "when firstname is not present" do
    before { @user.firstname = " " }
    it { should_not be_valid }
  end    

  describe "when lastname is not present" do
    before { @user.lastname = " " }
    it { should_not be_valid }
  end  

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when streetaddress is not present" do
    before { @user.streetaddress = " " }
    it { should_not be_valid }
  end

  describe "when city is not present" do
    before { @user.city = " " }
    it { should_not be_valid }
  end

  describe "when state is not present" do
    before { @user.state = " " }
    it { should_not be_valid }
  end

  describe "when zip is not present" do
    before { @user.zip = " " }
    it { should_not be_valid }
  end

  describe "when phone is not present" do
    before { @user.phone = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

######NAME######
  describe "when firstname is too long" do
    before { @user.firstname = "a" * 36 }
    it { should_not be_valid }
  end  

  describe "when lastname is too long" do
    before { @user.lastname = "a" * 36 }
    it { should_not be_valid }
  end

######EMAIL######
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

######PHONE######
  describe "when phone format is invalid" do 
  	it "should be invalid" do
  		phones = %w[444-555-7777 111.222.3333 444,555,7777 abcdefghij KLMNOPQRST]
  		phones.each do |invalid_phone|
  			@user.phone = invalid_phone
  			@user.should_not be_valid
  		end
  	end
  end

  describe "when phone format is valid" do
  	it "should be valid" do
  		phones = %w[1112223333]
  		phones.each do |valid_phone|
  			@user.phone = valid_phone
  			@user.should be_valid
  		end
  	end
  end

  describe "when phone is too long" do
    before { @user.phone = "a" * 11 }
    it { should_not be_valid }
  end

  describe "when phone is too short" do
    before { @user.phone = "a" * 9 }
    it { should_not be_valid }
  end

######STATE######
  describe "when state is too long" do
    before { @user.state = "a" * 3 }
    it { should_not be_valid }
  end

  describe "when state is too short" do
    before { @user.state = "a" * 1 }
    it { should_not be_valid }
  end

######ZIP######
  describe "when zip is too long" do
    before { @user.zip = "a" * 6 }
    it { should_not be_valid }
  end

  describe "when zip is too short" do
    before { @user.zip = "a" * 4 }
    it { should_not be_valid }
  end

  describe "when zip format is invalid" do 
    it "should be invalid" do
      zips = %w[abcde GGGGG @#$%&]
      zips.each do |invalid_zip|
        @user.zip = invalid_zip
        @user.should_not be_valid
      end
    end
  end

  describe "when zip format is valid" do
    it "should be valid" do
      zips = %w[12345]
      zips.each do |valid_zip|
        @user.zip = valid_zip
        @user.should be_valid
      end
    end
  end

######PASSWORD#######
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

######REMEMBER USER######
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
