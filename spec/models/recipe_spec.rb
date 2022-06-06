require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'レシピ作成' do
    let(:user) { FactoryBot.create(:user) }
    let(:recipe) { FactoryBot.build(:recipe) }

    context 'when recipe is valid' do
      it '値が入っている場合' do
        # recipe = described_class.new(user_id: user.id)
        expect(recipe).to be_valid
      end
    end
  end
end
