FactoryBot.define do
  factory :parking do
    plate { "FAA-1234" }
    paid { false  }


    trait :invalid_plate do
      plate { 'A1B-1234' }
    end
  end
end