class AddTitleToBasePrice < ActiveRecord::Migration[7.0]
  def change
    add_column :base_prices, :title, :string
  end
end
