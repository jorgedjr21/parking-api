class CreateParkings < ActiveRecord::Migration[5.2]
  def change
    create_table :parkings do |t|
      t.string :plate
      t.index :plate
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
