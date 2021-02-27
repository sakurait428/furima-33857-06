class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase_record
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :name
    validates :info, length: { maximum: 1000 }
    validates :price, numericality: {only_integer: true, message: 'は半角数字で入力して下さい'}
    validates :price, numericality: {greater_than_or_equal_to: 300, message: 'は300円以上にして下さい'}
    validates :price, numericality: {less_than_or_equal_to: 9999999, message: 'は10,000,000円未満にして下さい'}
  end

  with_options presence: true,numericality: { other_than: 1 , message: 'を選択して下さい'} do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

end
