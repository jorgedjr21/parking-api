# frozen_string_literal: true

# Parking controller. The api that handle the parking lot requests
class ParkingController < ApplicationController
  # Method when vehicle enter in parking lot
  def create
    parking = Parking.new(parking_params)
    if parking.save
      render json: parking.to_json, status: :created
    else
      render json: parking.errors, status: :bad_request
    end
  end

  private

  def parking_params
    params.permit(:plate)
  end
end
