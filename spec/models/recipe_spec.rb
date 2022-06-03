require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'レシピ作成' do
    let(:user) { FactoryBot.create(:user) }
    let(:recipe) { build(:recipe, user_id: user.id) }

    context 'when recipe is valid' do
      it '値が入っている場合' do
        recipe = described_class.new(
          name: 'test',
          user_id: user.id
        )
        puts recipe.name
        puts recipe.user_id
        expect(recipe).to be_valid
      end
    end
  end
end
