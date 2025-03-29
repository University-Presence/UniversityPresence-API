FactoryBot.define do
  factory :participant do
    event { nil }
    present { false }
    location { "MyString" }
  end
end
