# Class for Admin Users
# They are supposed to be allowed to edit anything
class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :trackable, and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :timeoutable, :lockable
end
