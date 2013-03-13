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

class User < ActiveRecord::Base
  attr_accessible :city, :email, :firstname, :lastname, :password, :password_confirmation, :phone, :state, :streetaddress, :zip
  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :firstname,  presence: true, length: { maximum: 35 }
  validates :lastname,  presence: true, length: { maximum: 35 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  VALID_STREETADDRESS_REGEX = /[a-zA-Z]/
  validates :streetaddress,  presence: true
  validates :city, presence: true
  VALID_STATE_REGEX = /[a-zA-Z]/
  validates :state,  presence: true, length: { is: 2 }, format: { with: VALID_STATE_REGEX }
  VALID_ZIP_REGEX = /\d/
  validates :zip, presence: true, length: { is: 5 }, format: { with: VALID_ZIP_REGEX }
  
  VALID_PHONE_REGEX = /\d{10}/
  validates :phone,  presence: true, length: { is: 10 }, format: { with: VALID_PHONE_REGEX }
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
