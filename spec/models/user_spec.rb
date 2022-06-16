require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    let(:user) { build(:user) }

    it 'email,name,password,password_confirmationが存在すれば登録できること' do
      expect(user).to be_valid
    end

    it 'emailが空では登録出来ないこと' do
      user.email = ''
      user.valid?
      expect(user.errors.full_messages).to include('Eメールを入力してください')
    end

    it '同じemailでは登録出来ないこと' do
      user1 = FactoryBot.create(:user)
      user.email = user1.email
      user.name = 'testdayo00'
      user.valid?
      expect(user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it '@のないメールアドレスを登録できないこと' do
      user.email = Faker::Lorem.characters(number: 10, min_alpha: 10)
      user.valid?
      expect(user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'nameが空では登録出来ないこと' do
      user.name = ''
      user.valid?
      expect(user.errors.full_messages).to include('ユーザー名を入力してください')
    end

    it 'nameが5文字より短いと登録出来ないこと' do
      user.name = 'test'
      user.valid?
      expect(user.errors.full_messages).to include('ユーザー名は5文字以上で入力してください')
    end

    it 'nameが15文字より長いと登録出来ないこと' do
      user.name = 'test1234567890test'
      user.valid?
      expect(user.errors.full_messages).to include('ユーザー名は15文字以内で入力してください')
    end

    it 'nameの最初の文字が数字だと登録出来ないこと' do
      user.name = '0test'
      user.valid?
      expect(user.errors.full_messages).to include('ユーザー名は最初の文字は半角英字、その後は半角英数を使って下さい')
    end

    it 'nameが英数以外だと登録出来ないこと' do
      user.name = 'テストst'
      user.valid?
      expect(user.errors.full_messages).to include('ユーザー名は最初の文字は半角英字、その後は半角英数を使って下さい')
    end

    it '同じnameでは登録出来ないこと' do
      user1 = FactoryBot.create(:user)
      user.name = user1.name
      user.email = 'testdayo00@test.com'
      user.valid?
      expect(user.errors.full_messages).to include('ユーザー名はすでに存在します')
    end

    it 'paswordが空では登録できないこと' do
      user.password = ''
      user.valid?
      expect(user.errors.full_messages).to include('パスワードを入力してください', 'パスワード（確認用）とパスワードの入力が一致しません')
    end

    it 'passworとpasword_confirmationが一致しないと登録できないこと' do
      user.password_confirmation = Faker::Lorem.characters(number: 6, min_alpha: 3, min_numeric: 2)
      user.valid?
      expect(user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
  end
end
