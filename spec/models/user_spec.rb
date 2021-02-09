require 'rails_helper'

RSpec.describe User, type: :model do

    before do
      @user = FactoryBot.build(:user) #FactoryBotの値を使用し、インスタンスを生成
    end

  describe '新規登録/ユーザー情報' do
    it 'ニックネームが必須であること' do
      @user.nickname = '' #nicknameの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = '' #emailの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)  #引数に”factory :user”を渡している
      another_user.email = @user.email #保存済みのemailを上書き
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'testtest'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      expect(@user).to be_valid
    end
    it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
      @user.password = "123abc"
      @user.password_confirmation = "123abc"
      expect(@user).to be_valid
    end
    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password = "123abc"
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
      @user.password = "123abc"
      @user.password_confirmation = "123abc4"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    it 'ユーザー本名は、名字が必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'ユーザー本名は、名前が必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'yamada'
      @user.last_name = 'rikutarou'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.", "First name is invalid. Input full-width characters.")
    end
    it 'ユーザー本名のフリガナは、名字が必須であること' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'ユーザー本名のフリガナは、名前が必須であること' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana = 'やまだ'
      @user.last_name_kana = 'りくたろう'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters.", "First name kana is invalid. Input full-width katakana characters.")
    end
    it '生年月日が必須であること' do
      @user.user_birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("User birth date can't be blank")
    end
  end
end


