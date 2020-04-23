# frozen_string_literal: true

# Parking controller. The api that handle the parking lot requests
class ParkingController < ApplicationController
  before_action :set_parking, only: %i[out pay]
  before_action :parkings_by_plate, only: :show
  # Method used when vehicle enter in parking lot
  def create
    parking = Parking.new(parking_params)
    if parking.save
      render json: { message: 'Vehicle entrance with success', data: parking, status: 201 }, status: :created
    else
      render json: { message: 'Something went wrong', errors: parking.errors, status: 401 }, status: :bad_request
    end
  end

  def show
    render json: @parkings, each_serializer: ParkingSerializer
  end

  # Method used when vehicle quit the parking lot
  def out
    out_result = { message: '', status: 200 }

    if @parking.paid_at.present?
      @parking.quit!
      out_result = {
        message: "Vehicle #{@parking.plate} out with success",
        data: @parking.serialized
      }
    else
      out_result = {
        message: "Vehicle #{@parking.plate} didn't pay the parking and can't exit",
        status: 403
      }
    end

    render json: out_result, status: out_result[:status]
  end

  # Method used to pay the parking over a request
  def pay
    return render json: { message: 'Parking payment done before', data: @parking.serialized, status: 200 }, status: :ok if @parking.paid_at.present?

    @parking.pay!
    render json: { message: 'Parking payment done', data: @parking.serialized, status: 200 }, status: :ok
  end

  private

  def parking_params
    params.permit(:id, :plate)
  end

  def set_parking
    @parking = Parking.find_by(id: parking_params['id'])
    result = { message: "Parking booking ##{parking_params['id']} not found", status: 404 }
    render json: result, status: :not_found if @parking.blank?
  end

  def parkings_by_plate
    @parkings = Parking.where(plate: parking_params['plate'])
  end
end
