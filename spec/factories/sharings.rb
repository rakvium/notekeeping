FactoryGirl.define do
  factory :sharing do
    sender { FactoryGirl.create(:user) }
    recipient { FactoryGirl.create(:user) }
    note { FactoryGirl.create(:note, user_id: sender.id) }
    permission 'reader'
  end
end
