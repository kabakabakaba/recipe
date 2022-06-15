require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { create(:user) }

  describe 'GET /index' do
    it 'ログインしていない場合、リダイレクトされる' do
      sign_out user
      get '/recipes/index'
      expect(response).to have_http_status(:found)
    end

    it 'ログインしている場合、アクセスできる' do
      sign_in user
      get '/recipes/index'
      assert_response :success
    end
  end
end
