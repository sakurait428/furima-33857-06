FactoryBot.define do
  factory :user do
    nickname                 {Faker::Name.last_name}
    email                    {Faker::Internet.free_email}
    password = '1a' + Faker::Internet.password(min_length: 4)
    password                 {password}
    password_confirmation    {password}
    last_name                {'山田'}
    first_name               {'陸太郎'}
    last_name_kana           {'ヤマダ'}
    first_name_kana          {'リクタロウ'}
    user_birth_date          {Faker::Date.between(from: '1930-01-01', to: '2016-12-31')}
  end
end