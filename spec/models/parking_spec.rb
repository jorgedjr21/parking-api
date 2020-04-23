require 'rails_helper'

# frozen_string_literal: true
RSpec.describe Parking, type: :model do
  describe 'quit!' do
    context 'when parking already paid' do
      it 'must update the parking data' do
        parking = create(:parking, :paid)
        expect { parking.quit! }.to change(parking, :updated_at)
      end
    end

    context 'when parking is not paid' do
      it 'must not update the parking data' do
        parking = create(:parking)
        expect { parking.quit! }.not_to change(parking, :updated_at)
      end
    end
  end

  describe 'pay!' do
    context 'when parking already paid' do
      it 'must not update the parking paid_at data' do
        parking = create(:parking, :paid)
        expect { parking.pay! }.not_to change(parking, :paid_at)
      end
    end
    context 'when parking is not paid' do
      it 'must update the parking paid_at data' do
        parking = create(:parking)
        expect { parking.pay! }.to change(parking, :paid_at)
      end
    end
  end

  describe 'vehicle plate validation' do
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
