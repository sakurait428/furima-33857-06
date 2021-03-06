require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
      @item = FactoryBot.build(:item)
  end

  describe '商品新規登録' do
    
    context "商品登録ができる時" do
      it '各フォームが入力されていてば、登録が可能なこと' do
        expect(@item).to be_valid
      end
    end

    context "商品登録ができない時" do
      it '出品画像が必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が必須であること' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が必須であること' do
        @item.info = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it '商品の説明が１０００文字を超えると登録できないこと' do
        @item.info = Faker::Alphanumeric.alpha(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Info is too long (maximum is 1000 characters)")
      end
      it 'カテゴリーが必須であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択して下さい")
      end
      it 'カテゴリーが未選択では登録できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択して下さい")
      end
      it '商品の状態が必須であること' do
        @item.sales_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end
      it '商品の状態が未選択では登録できないこと' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status を選択して下さい")
      end
      it '配送料の負担が必須であること' do
        @item.shipping_fee_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end
      it '配送料の負担が未選択では登録できないこと' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status を選択して下さい")
      end
      it '発送元の地域が必須であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域が未選択では登録できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture を選択して下さい")
      end
      it '発送までの日数が必須であること' do
        @item.scheduled_delivery_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
      it '発送までの日数が未選択では登録できないこと' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery を選択して下さい")
      end
      it '販売価格が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が300円未満だと登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300円以上にして下さい")
      end
      it '販売価格が9999999を超えると登録できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は10,000,000円未満にして下さい")
      end
      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = "１２３４５"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字で入力して下さい")
      end
    end
  end
end

