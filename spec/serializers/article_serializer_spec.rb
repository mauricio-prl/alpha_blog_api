require 'rails_helper'

RSpec.describe ArticleSerializer do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let!(:serializer) { described_class.new(article) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  
  subject { JSON.parse(serialization.to_json) }

  it 'returns a serialized hash' do
    is_expected.to include('id')
    is_expected.to include('title')
    is_expected.to include('user')
    is_expected.to include('created_at')
    is_expected.to include('updated_at')
    is_expected.to include('categories')
  end
end
