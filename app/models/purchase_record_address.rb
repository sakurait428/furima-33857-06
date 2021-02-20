class PurchaseRecordAddress
  include ActiveModel::Model
  attr_accessor :user, :item, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :purchase_record


  def save

    purchase_record = PurchaseRecord.create(user: user, item: item)

    Address.create(postal_code: postal_code, prefecture_id: prefecture.id, city: city, address: address, building: building, phone_number: phone_number, purchase_record: purchase_record)

  end
end