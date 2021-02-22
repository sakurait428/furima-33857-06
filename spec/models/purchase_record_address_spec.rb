require 'rails_helper'

RSpec.describe PurchaseRecordAddress, type: :model do

  before do
    @purchase_record_address = FactoryBot.build(:purchase_record_address)
  end

  describe '商品購入' do
    
    context "商品購入ができる時" do
      it '必要な情報を適切に入力すると、商品の購入ができること' do
          expect(@purchase_record_address).to be_valid
      end
      it '建物名を入力しなくても、商品の購入ができること' do
        @purchase_record_address.building = nil
        expect(@purchase_record_address).to be_valid
      end
    end

    context "商品購入ができない時" do
      it '正しいクレジットカードの情報で無いときは決済できないこと' do
        @purchase_record_address.token = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が必須であること' do
        @purchase_record_address.postal_code = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号の保存にはハイフンが必要であること' do
        @purchase_record_address.postal_code = 1234567
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Postal code is invalid")
      end
      it '都道府県が未選択では登録できないこと' do
        @purchase_record_address.prefecture_id = 1
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '市区町村が必須であること' do
        @purchase_record_address.city = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が必須であること' do
        @purchase_record_address.address = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が必須であること' do
        @purchase_record_address.phone_number = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は11桁以内のみ保存可能なこと' do
        @purchase_record_address.phone_number = "080123456789"
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it '電話番号は数値のみ保存可能なこと' do
        @purchase_record_address.phone_number = "080-123-456"
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Phone number is invalid")
      end
    end

  end
end
