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
        expect(plate_error['errors']['plate']).to include('invalid plate format')
      end
    end
  end

  describe 'PUT /parking/:id/pay' do
    let(:parking) { create(:parking) }
    let(:paid_parking) { create(:parking, :paid) }

    context 'when not paid' do
      it 'must update the parking paid time' do
        put :pay, params: { id: parking.id }
        message = JSON.parse(response.body)['message']

        expect(parking.reload.paid_at).not_to be_nil
        expect(message).to eq('Parking payment done')
      end
    end

    context 'when is already paid' do
      it 'must just return the parking' do
        put :pay, params: { id: paid_parking.id }

        message = JSON.parse(response.body)['message']
        expect(message).to eq('Parking payment done before')
      end
    end
  end

  describe 'PUT /parking/:id/out' do
    let(:parking) { create(:parking) }
    let(:paid_parking) { create(:parking, :paid) }

    context 'when is paid' do
      it 'must update the updated_at parking time' do
        parking_time = paid_parking.updated_at
        put :out, params: { id: paid_parking.id }

        message = JSON.parse(response.body)['message']
        expect(paid_parking.reload.updated_at).to_not eq(parking_time)
        expect(message).to eq("Vehicle #{paid_parking.plate} out with success")
      end
    end

    context 'when is not paid' do
      it 'must not allow the exit' do
        parking_time = parking.updated_at
        put :out, params: { id: parking.id }

        message = JSON.parse(response.body)['message']
        expect(parking.reload.updated_at).to_not eq(parking_time)
        expect(message).to eq("Vehicle #{parking.plate} didn't pay the parking and can't exit")
      end
    end
  end

  describe 'GET /parking/:plate' do
    let!(:parkings_empty) { create_list(:parking, 5, plate: 'AAA-1234') }
    let!(:parkings_informed) do
      create_list(
        :parking,
        5,
        plate: 'AAA-1234',
        paid_at: Time.zone.now + rand(5..10).minutes,
        exit_at: Time.zone.now + rand(20..30).minutes
      )
    end

    context 'when car alread parked' do
      it 'must show a historic of parking' do
        get :show, params: { plate: 'AAA-1234' }

        body = JSON.parse(response.body)
        expect(body.count).to eq(10)
      end
    end

    context 'when car not parked' do
      it 'must show a historic of parking' do
        get :show, params: { plate: 'AAA-2234' }

        body = JSON.parse(response.body)
        expect(body.count).to eq(0)
      end
    end
  end
end
