class User < ActiveRecord::Base
  has_many  :tasks

  has_secure_password

  validates_uniqueness_of :username
  validates_uniqueness_of :email
end
