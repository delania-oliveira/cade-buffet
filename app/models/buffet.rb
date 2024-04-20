class Buffet < ApplicationRecord
  belongs_to :user
  validates :corporate_name, :brand_name, :registration_number, :telephone, 
            :email, :address, :district, :cep, :city, :state, :description, 
            :payment_methods, presence: true
  validates :registration_number, uniqueness: true
  validates :user_id, uniqueness: true
end
