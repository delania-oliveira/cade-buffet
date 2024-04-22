class CreateBasePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :base_prices do |t|
      t.decimal :minimum_value, precision: 12, scale: 2
      t.decimal :additional_value_per_person, precision: 12, scale: 2
      t.decimal :extra_hour_value, precision: 12, scale: 2
      t.references :event_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
