class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :trackable, :timeoutable

  validates :name, presence: true, length: { in: 5..15 }, format: { with: /\A[a-z][a-z0-9]+\z/i, message: 'は最初の文字は半角英字、その後は半角英数を使って下さい' }
end
