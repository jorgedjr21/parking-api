class RemovePaidColumnFromParkings < ActiveRecord::Migration[5.2]
  def change
    remove_column :parkings, :paid
  end
end
