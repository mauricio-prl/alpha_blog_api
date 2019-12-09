require 'rails_helper'

RSpec.describe UserSerializer do
  let!(:user) { create(:user) }
  let!(:serializer) { described_class.new(user) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  
  subject { JSON.parse(serialization.to_json) }

  it 'returns a serialized hash' do
    serialized_user = { 
      "articles"=>user.articles, 
      "email"=>user.email, 
      "id"=>user.id, 
      "username"=>user.username 
    }

    is_expected.to eq(serialized_user) 
  end
end
