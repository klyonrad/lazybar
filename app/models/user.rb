# Class for Simple Users
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :trackable, and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :timeoutable
end
