require 'rails_helper'

RSpec.describe Sharing, type: :model do
  subject { FactoryGirl.create(:sharing) }

  describe 'relations' do
    it { should belong_to(:note) }
    it { should belong_to(:recipient).class_name('User') }
    it { should belong_to(:sender).class_name('User') }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:recipient_id).scoped_to(:note_id) }
  end
end
