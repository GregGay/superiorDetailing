class Appointment < ActiveRecord::Base
  attr_accessible :date, :date2, :date3, :date4, :date5,:date6, :date7, :date8, :package, :package2, :package3, :package4, :package5, :package6, :package7, :package8
  belongs_to :user

###PACKAGE###
  validates :package, presence: true

###USER_ID###
  validates :user_id, presence: true

  default_scope order: 'appointments.created_at DESC'
end
