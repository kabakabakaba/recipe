class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { in: 1..50 }
  validates :text, length: { maximum: 300 }
  validates :user_id, presence: true
end
