class CreateEventTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :event_types do |t|
      t.string :name
      t.text :description
      t.integer :capacity_min
      t.integer :capacity_max
      t.integer :duration
      t.text :food_menu
      t.boolean :alcoholic_drinks
      t.boolean :decoration
      t.boolean :parking_service
      t.boolean :buffet_exclusive_address
      t.boolean :client_specified_address
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
