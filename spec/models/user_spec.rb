require 'rails_helper'

RSpec.describe User, type: :model do

  before do
      @user = FactoryBot.build(:user) #FactoryBotの値を使用し、インスタンスを生成
  end

  describe 'ユーザー新規登録' do
    
    context "ユーザー登録ができる時" do
      it '各フォームが入力されていてば、登録が可能なこと' do
        expect(@user).to be_valid
      end
      it 'パスワードは、６文字以上で半角英数字が混合されていれば、登録が可能なこと' do
        @user.password = "123abc"
        @user.password_confirmation = "123abc"
        expect(@user).to be_valid
      end
    end

    context "ユーザー登録ができない時" do
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
      it 'パスワードが全角では登録できないこと' do
        @user.password = 'ｐａｓｓｗｏｒｄ１２３'
        @user.password_confirmation = "ｐａｓｓｗｏｒｄ１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが半角数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが半角英語のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが６文字以上でないと登録できないこと' do
        @user.password = 'ab12'
        @user.password_confirmation = "ab12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password = "abcd12"
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
      it 'ユーザー本名（名字）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it 'ユーザー本名（名前）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'rikutarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.")
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
      it 'ユーザー本名（名字）のフリガナは、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters.")
      end
      it 'ユーザー本名（名前）のフリガナは、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters.")
      end
      it '生年月日が必須であること' do
        @user.user_birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("User birth date can't be blank")
      end
    end
  end
end