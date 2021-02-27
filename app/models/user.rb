class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :user_birth_date
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は、全角（漢字・ひらがな・カタカナ）で入力して下さい' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: 'は、全角（漢字・ひらがな・カタカナ）で入力して下さい' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }

  has_many :items
  has_many :purchase_records

end
