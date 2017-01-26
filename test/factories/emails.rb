FactoryGirl.define do
  factory :email do
    username { Faker::Internet.user_name + '@' + domain.name.to_s }
    quota { (rand * 100 + 1).to_i }
    password { Faker::Internet.password(8) }
    domain
  end
end
