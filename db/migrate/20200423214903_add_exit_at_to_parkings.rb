class AddExitAtToParkings < ActiveRecord::Migration[5.2]
  def change
    add_column :parkings, :exit_at, :datetime
  end
end
