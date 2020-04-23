require 'rails_helper'

# frozen_string_literal: true
RSpec.describe Parking, type: :model do
  context 'vehicle plate' do
    context 'correct format' do
      it 'should be valid' do
        parking = build(:parking)
        expect(parking.valid?).to be_truthy
      end
    end

    context 'wrong format' do
      it 'should be invalid' do
        parking = build(:parking, :invalid_plate)
        expect(parking.invalid?).to be_truthy
      end

      it 'should not save' do
        parking = build(:parking, :invalid_plate)
        expect { parking.save }.to_not change(Parking, :count)
      end
    end
  end
end
