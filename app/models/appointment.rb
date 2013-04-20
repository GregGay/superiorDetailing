class Appointment < ActiveRecord::Base
  attr_accessible :date, :date2, :date3, :date4, :date5,:date6, :date7, :date8, :package, :package2, :package3, :package4, :package5, :package6, :package7, :package8
  belongs_to :user

###PACKAGE###
  validates :package, presence: true, :unless => :package2?, :unless => :package3?, :unless => :package4?, :unless => :package5?, :unless => :package6?, :unless => :package7?, :unless => :package8?
  validates :package2, presence: true, :unless => :package?, :unless => :package3?, :unless => :package4?, :unless => :package5?, :unless => :package6?, :unless => :package7?, :unless => :package8?
  validates :package3, presence: true, :unless => :package?, :unless => :package2?, :unless => :package4?, :unless => :package5?, :unless => :package6?, :unless => :package7?, :unless => :package8?
  validates :package4, presence: true, :unless => :package?, :unless => :package2?, :unless => :package3?, :unless => :package5?, :unless => :package6?, :unless => :package7?, :unless => :package8?
  validates :package5, presence: true, :unless => :package?, :unless => :package2?, :unless => :package3?, :unless => :package4?, :unless => :package6?, :unless => :package7?, :unless => :package8?
  validates :package6, presence: true, :unless => :package?, :unless => :package2?, :unless => :package3?, :unless => :package4?, :unless => :package5?, :unless => :package7?, :unless => :package8?
  validates :package7, presence: true, :unless => :package?, :unless => :package2?, :unless => :package3?, :unless => :package4?, :unless => :package5?, :unless => :package6?, :unless => :package8?
  validates :package8, presence: true, :unless => :package?, :unless => :package2?, :unless => :package3?, :unless => :package4?, :unless => :package5?, :unless => :package6?, :unless => :package7?
  
###DATE###
  validates :date, presence: true, :unless => :date2?, :unless => :date3?, :unless => :date4?, :unless => :date5?, :unless => :date6?, :unless => :date7?, :unless => :date8?, uniqueness: true
  validates :date2, presence: true, :unless => :date?, :unless => :date3?, :unless => :date4?, :unless => :date5?, :unless => :date6?, :unless => :date7?, :unless => :date8?, uniqueness: true
  validates :date3, presence: true, :unless => :date?, :unless => :date2?, :unless => :date4?, :unless => :date5?, :unless => :date6?, :unless => :date7?, :unless => :date8?, uniqueness: true
  validates :date4, presence: true, :unless => :date?, :unless => :date2?, :unless => :date3?, :unless => :date5?, :unless => :date6?, :unless => :date7?, :unless => :date8?, uniqueness: true
  validates :date5, presence: true, :unless => :date?, :unless => :date2?, :unless => :date3?, :unless => :date4?, :unless => :date6?, :unless => :date7?, :unless => :date8?, uniqueness: true
  validates :date6, presence: true, :unless => :date?, :unless => :date2?, :unless => :date3?, :unless => :date4?, :unless => :date5?, :unless => :date7?, :unless => :date8?, uniqueness: true
  validates :date7, presence: true, :unless => :date?, :unless => :date2?, :unless => :date3?, :unless => :date4?, :unless => :date5?, :unless => :date6?, :unless => :date8?, uniqueness: true
  validates :date8, presence: true, :unless => :date?, :unless => :date2?, :unless => :date3?, :unless => :date4?, :unless => :date5?, :unless => :date6?, :unless => :date7?, uniqueness: true


###USER_ID###
  validates :user_id, presence: true

  default_scope order: 'appointments.created_at DESC'
end
