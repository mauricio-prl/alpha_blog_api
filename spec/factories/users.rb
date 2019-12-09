FactoryBot.define do
  factory :user do
    username { "new_user" }
    email { "new_user@email.com" }
    password { 'password' }
  end
end
