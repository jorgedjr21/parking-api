class AddPaidAtToParkingTable < ActiveRecord::Migration[5.2]
  def change
    add_column :parkings, :paid_at, :datetime
  end
end
