class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.text :text
      t.date :recent_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
