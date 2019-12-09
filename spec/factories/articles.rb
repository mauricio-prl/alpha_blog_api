FactoryBot.define do
  factory :article do
    title { 'New article' }
    description { 'New description' }
    user
  end
end
