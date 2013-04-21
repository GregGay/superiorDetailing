class Appointment < ActiveRecord::Base
  attr_accessible :date, :date2, :date3, :date4, :date5,:date6, :date7, :date8, :package, :package2
  belongs_to :user

###PACKAGE###
  validates :package, presence: true

###DATE###
  #validates :date, presence: { :if => :date2? && :date3? && :date4? && :date5? && :date6? && :date7? && :date8? }, uniqueness: true
  #validates :date2, presence: { :if => :date? && :date3? && :date4? && :date5? && :date6? && :date7? && :date8? }, uniqueness: true
  #validates :date3, presence: { :if => :date? && :date2? && :date4? && :date5? && :date6? && :date7? && :date8? }, uniqueness: true
  #validates :date4, presence: { :if => :date? && :date2? && :date3? && :date5? && :date6? && :date7? && :date8? }, uniqueness: true
  #validates :date5, presence: { :if => :date? && :date2? && :date3? && :date4? && :date6? && :date7? && :date8? }, uniqueness: true
  #validates :date6, presence: { :if => :date? && :date2? && :date3? && :date4? && :date5? && :date7? && :date8? }, uniqueness: true
  #validates :date7, presence: { :if => :date? && :date2? && :date3? && :date4? && :date5? && :date6? && :date8? }, uniqueness: true
  #validates :date8, presence: { :if => :date? && :date2? && :date3? && :date4? && :date5? && :date6? && :date7? }, uniqueness: true

###USER_ID###
  validates :user_id, presence: true

  default_scope order: 'appointments.created_at DESC'
end
