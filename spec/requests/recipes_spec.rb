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
    let(:other_user) { create(:user) }
    let(:other_recipe) { create(:recipe, user_id: other_user.id) }

    context 'without ログイン' do
      it 'ログインしていない場合、リダイレクトされる' do
        get "/recipes/#{recipe.id}"
        expect(response).to have_http_status(:found)
      end

      it 'ログインしていない場合、サインインに遷移される' do
        get "/recipes/#{recipe.id}"
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when ログイン状態' do
      it 'ログインしていて、自分のレシピならアクセスできる' do
        sign_in user
        get "/recipes/#{recipe.id}"
        assert_response :success
      end

      it '違うユーザーのレシピにアクセスするとリダイレクトされる' do
        sign_in user
        get "/recipes/#{other_recipe.id}"
        expect(response).to have_http_status(:found)
      end

      it '違うユーザーのレシピにアクセスするとレシピ一覧にリダイレクトされる' do
        sign_in user
        get "/recipes/#{other_recipe.id}"
        expect(response).to redirect_to('/recipes')
      end
    end
  end

  describe 'POST /recipes' do
    let(:user) { create(:user) }

    context 'when ログイン状態' do
      before do
        sign_in user
        @recipe_params = FactoryBot.attributes_for(:recipe)
        @recipe_params['user_id'] = user.id
      end

      it 'リクエストが成功したらshowアクションにリダイレクトすること' do
        post recipes_path, params: { recipe: @recipe_params }
        expect(response).to redirect_to(recipes_path)
      end

      it 'リクエストが成功したらレシピが１件保存されていること' do
        expect {
          post recipes_path, params: { recipe: @recipe_params }
        }.to change(user.recipes, :count).by(1)
      end

      it 'リクエストが不正な場合は保存されていないこと' do
        @recipe_params[:name] = ''
        expect {
          post recipes_path, params: { recipe: @recipe_params }
        }.to change(user.recipes, :count).by(0)
      end
    end
  end

  describe 'PUT /recipes' do

  end
end
