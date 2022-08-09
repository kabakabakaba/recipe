require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'レシピ作成' do
    let(:user) { FactoryBot.create(:user) }
    let(:recipe) { FactoryBot.build(:recipe) }

    before do
      recipe.user_id = user.id
    end

    context 'when recipe is valid' do
      it '値が入っている場合' do
        expect(recipe).to be_valid
      end
    end

    context 'when レシピ名が入っていない' do
      it 'バリデーションエラーが出ること' do
        recipe.name = nil
        expect(recipe).to be_invalid
      end

      it 'nameが0文字だとエラー' do
        recipe.name = ''
        expect(recipe).to be_invalid
      end

      it 'nameが51文字以上だとエラー' do
        recipe.name = Faker::Lorem.characters(number: 51)
        expect(recipe).to be_invalid
      end
    end

    context 'when テキストが入っていない' do
      it 'エラーにならない' do
        recipe.text = nil
        expect(recipe).to be_valid
      end

      it '300文字より多い' do
        recipe.text = Faker::Lorem.characters(number: 301)
        expect(recipe).to be_invalid
      end
    end

    context 'when user is nothing' do
      it 'エラーになる' do
        recipe.user_id = nil
        expect(recipe).to be_invalid
      end
    end

    context 'when recent_at is nothing' do
      it 'valid' do
        recipe.recent_at = nil
        expect(recipe).to be_valid
      end
    end
  end
end
