class Appointment < ActiveRecord::Base
  attr_accessible :date, :package
  belongs_to :user

###PACKAGE###
  validates :package, presence: true
###DATE###
  validates :date, presence: true


###USER_ID###
  validates :user_id, presence: true

  default_scope order: 'appointments.created_at DESC'
end