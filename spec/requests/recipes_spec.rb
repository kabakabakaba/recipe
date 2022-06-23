require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { create(:user) }
  let(:recipe) { build(:recipe) }

  describe 'GET /index' do
    it 'ログインしていない場合、リダイレクトされる' do
      get '/recipes'
      expect(response).to have_http_status(:found)
    end

    it 'ログインしていない場合、サインインに遷移される' do
      get '/recipes'
      expect(response).to redirect_to('/users/sign_in')
    end

    it 'ログインしている場合、アクセスできる' do
      sign_in user
      get '/recipes'
      assert_response :success
    end
  end

  describe 'GET /show' do
    context 'without ログイン' do
      before do
        @user = user
        other_user = user
        @recipe = FactoryBot.create(:recipe, user_id: other_user.id)
      end

      it 'ログインしていない場合、リダイレクトされる' do
        puts @recipe.id
        get :show, params: { id: @recipe.id }
        expect(response).to have_http_status(:found)
      end

      it 'ログインしていない場合、サインインに遷移される' do
        get '/recipes'
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
