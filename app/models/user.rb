class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :trackable, :timeoutable

  with_options presence: true, uniqueness: true do
    validates :email
    validates :name, length: { in: 5..15, allow_blank: true }, format: { with: /\A[a-z][a-z0-9]+\z/i, message: 'は最初の文字は半角英字、その後は半角英数を使って下さい', allow_blank: true }
  end
end
