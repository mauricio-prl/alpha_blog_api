require 'rails_helper'

RSpec.describe CategorySerializer do
  let(:category) { create(:category) }
  let!(:serializer) { described_class.new(category) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  
  subject { JSON.parse(serialization.to_json) }

  it 'returns a serialized hash' do
    is_expected.to include('id')
    is_expected.to include('name')
    is_expected.to include('articles')
  end
end
