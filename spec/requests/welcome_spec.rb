require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  describe "GET /index" do
    it 'リクエストが成功すること' do
      get "/"
      assert_response :success
    end
  end
end
