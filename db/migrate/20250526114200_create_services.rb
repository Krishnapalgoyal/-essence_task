class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.references :service_provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
