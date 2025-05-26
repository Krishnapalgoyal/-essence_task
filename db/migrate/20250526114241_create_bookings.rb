class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :service, null: false, foreign_key: true
      t.references :service_provider, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :service_available_slot, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
