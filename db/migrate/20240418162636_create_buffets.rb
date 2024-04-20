class CreateBuffets < ActiveRecord::Migration[7.0]
  def change
    create_table :buffets do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :registration_number
      t.string :telephone
      t.string :email
      t.string :address
      t.string :district
      t.string :cep
      t.string :city
      t.string :state
      t.string :description
      t.string :payment_methods

      t.timestamps
    end
  end
end
