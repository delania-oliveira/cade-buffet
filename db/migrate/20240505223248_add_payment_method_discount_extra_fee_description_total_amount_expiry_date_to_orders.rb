class AddPaymentMethodDiscountExtraFeeDescriptionTotalAmountExpiryDateToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :discount, :integer
    add_column :orders, :extra_fee, :integer
    add_column :orders, :description, :text
    add_column :orders, :total_amount, :integer
    add_column :orders, :expiry_date, :datetime
  end
end
