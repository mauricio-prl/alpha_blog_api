require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }

    describe 'same article can not be twice in the same category' do
      let!(:category) { create(:category, name: 'Test') }
      let!(:user) { create(:user) }
      let!(:article) { create(:article, user: user, categories: [category]) }

      it 'raises errors' do
        expect{ article.categories << category }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end

  describe 'assiciations' do
    it { is_expected.to have_and_belong_to_many(:articles) }
  end
end
