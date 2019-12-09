FactoryBot.define do
  factory :article do
    title { FFaker::CheesyLingo.title }
    description { FFaker::Book.description }
    user
  end
end
