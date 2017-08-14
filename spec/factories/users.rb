FactoryGirl.define do 
  sequence :email do |n|
    "person#{n}@example.com"
  end
   
  factory :user do
    email { FactoryGirl.generate :email }
    name  { Faker::Name.name }
    password 'password'
    password_confirmation 'password'

    factory :invalid_user do 
      email  'invalid_user.com'
    end
  end 
end