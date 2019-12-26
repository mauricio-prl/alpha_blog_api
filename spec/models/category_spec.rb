require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { create(:category); is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'assiciations' do
    it { is_expected.to have_and_belong_to_many(:articles) }
  end
end
