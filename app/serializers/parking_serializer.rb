# frozen_string_literal: true

# Parking Model serializer
class ParkingSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :time, :paid, :parked_at, :paid_at, :exit_at

  # attribute serialization definition
  def time
    distance_of_time_in_words(@object.created_at, @object.exit_at) if @object.exit_at.present?
  end

  # attribute serialization definition
  def paid
    @object.paid_at.present?
  end

  # attribute serialization definition
  def parked_at
    @object.created_at.strftime('%d %B %Y, %H:%M:%I') if @object.created_at.present?
  end

  # attribute serialization definition
  def paid_at
    @object.paid_at.strftime('%d %B %Y, %H:%M:%I') if @object.paid_at.present?
  end

  # attribute serialization definition
  def exit_at
    @object.exit_at.strftime('%d %B %Y, %H:%M:%I') if @object.exit_at.present?
  end
end
