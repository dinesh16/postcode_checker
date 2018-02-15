FactoryBot.define do
  factory :delivery_office do
    name Faker::Company.name
    address Faker::Address.street_name
    postcode 'WD18 7QP'
  end
end
