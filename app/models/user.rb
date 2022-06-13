class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :trackable, :timeoutable
end
