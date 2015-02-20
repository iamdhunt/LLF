# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mention do
    mentionable_id 1
    mentionable_type "MyString"
  end
end
