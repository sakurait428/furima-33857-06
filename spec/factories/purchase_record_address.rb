FactoryBot.define do
  factory :purchase_record_address do

    postal_code          {'123-' + Faker::Number.number(digits: 4).to_s}
    prefecture_id        {Faker::Number.within(range: 2..48)}
    city                 {Faker::Address.city}
    address              {Faker::Address.street_address}
    building             {Faker::Address.building_number}
    phone_number         {Faker::Number.number(digits: 10)}
    token {'tok_' + Faker::Alphanumeric.alphanumeric(number: 28)}

  end
end
