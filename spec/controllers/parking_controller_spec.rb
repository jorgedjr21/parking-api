require 'rails_helper'
# frozen_string_literal: true

RSpec.describe ParkingController, type: :controller do
  let(:valid_params) do
    {
      plate: "#{(0...3).map { rand(65..90).chr }.join}-#{Random.rand(1000..9999)}"
    }
  end

  let(:invalid_params) do
    {
      plate: 'FAA-1A34'
    }
  end

  describe 'POST /parking' do
    context 'with valid params' do
      it 'must create the parking' do
        expect { post :create, params: valid_params }.to change(Parking, :count).by(1)
      end

      it 'must create the parking with the vehichle plate' do
        post :create, params: valid_params
        expect(Parking.last.plate).to eq(valid_params[:plate])
      end
    end

    context 'with invalid params' do
      it 'must not create the parking' do
        expect { post :create, params: invalid_params }.not_to change(Parking, :count)
      end

      it 'must have plate error message' do
        post :create, params: invalid_params
        plate_error = JSON.parse(response.body)
        expect(plate_error['plate']).to include('invalid plate format')
      end
    end
  end
end
