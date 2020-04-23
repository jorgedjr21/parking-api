# frozen_string_literal: true

FactoryBot.define do
  factory :parking do
    plate { 'FAA-1234' }
    paid_at { nil }

    trait :invalid_plate do
      plate { 'A1B-1234' }
    end

    trait :paid do
      paid_at { Time.zone.now }
    end
  end
end
