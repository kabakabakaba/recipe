require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  let(:user) { create(:user) }

  describe "GET /index" do
    it 'リクエストが成功すること' do
      get "/"
      assert_response :success
    end

    it 'ログインが成功すること' do
      sign_in user
    end

    it 'サインアウトすること' do
      sign_out user
    end
  end
end
