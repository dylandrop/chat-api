FactoryGirl.define do
  factory :message do
    content 'Blahblah'
    
    user
    conversation
  end
end
