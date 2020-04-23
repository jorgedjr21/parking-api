# frozen_string_literal: true

# Parking model represents the parking of an vehicle in some parking lot
class Parking < ApplicationRecord
  validates :plate, presence: true, format: { with: /\A[A-Z]{3}-[0-9]{4}/, message: 'invalid plate format' }

  # Adds the exit event of a vehicle
  def quit!
    update!(exit_at: Time.zone.now) if paid_at.present?
  end

  # Update the payment time of the parking (Do the payment)
  def pay!
    update!(paid_at: Time.zone.now) if paid_at.blank?
  end

  # Represents the model with the serialization rules
  def serialized
    ActiveModelSerializers::SerializableResource.new(self, {})
  end
end
