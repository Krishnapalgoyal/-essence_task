class CreateServiceAvailableSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :service_available_slots do |t|
      t.references :service, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
