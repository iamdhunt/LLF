# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    brand nil
    member nil
    title "MyText"
    category "MyText"
    subcategory "MyText"
    description "MyText"
    price 1
  end
end
