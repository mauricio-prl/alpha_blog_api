require 'rails_helper'

RSpec.describe ArticleSerializer do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let!(:serializer) { described_class.new(article) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  
  subject { JSON.parse(serialization.to_json) }

  it 'returns a serialized hash' do
    serialized_article = {
      "id" => article.id,
      "title" => article.title,
      "description" => article.description, 
      "user" => {
        "email" => user.email, "id" => user.id, "username" => user.username
      }
    }

    is_expected.to eq(serialized_article)
  end
end
