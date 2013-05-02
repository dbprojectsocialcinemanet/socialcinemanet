class User < ActiveRecord::Base
  attr_accessible :dob, :email, :fname, :is_admin, :lname, :mname, :password
  
  validates_presence_of :fname
  validates_presence_of :lname
  validates_presence_of :email
  validates_presence_of :dob
  validates_presence_of :password
  
  validates_uniqueness_of :email
end
