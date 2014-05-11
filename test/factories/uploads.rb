# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload do
    uploadable_id 1
    uploadable_type "MyString"
  end
end
