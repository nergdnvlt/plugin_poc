FactoryBot.define do
  factory :user do
    fs_id { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    country { "MyString" }
    zipcode { 1 }
  end
end
