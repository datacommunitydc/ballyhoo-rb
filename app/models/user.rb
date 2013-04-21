# == Schema Information
# Schema version: 20130415025142
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_secure_password validations: false

  has_many :user_meetups, dependent: :destroy
  has_many :meetups, through: :user_meetups

  validates_uniqueness_of :email
  validates_confirmation_of :password

  def self.login(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  def refresh_meetups!
    self.user_meetups.delete_all
    list = MeetupFinder.meetups_for(self)
    if list.try(:any?)
      self.user_meetups = list
    end
    save
  end
end
