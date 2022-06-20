class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { in: 1..50 }
  validates :text, length: { maximum: 300 }
  validates :user_id, presence: true

  def self.user_recipe_get(user_bigint)
    Recipe.where(user_id: user_bigint)
  end
end
