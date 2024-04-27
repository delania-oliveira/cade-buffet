class EventType < ApplicationRecord
  belongs_to :buffet
  has_many :base_prices
  has_many_attached :images, dependent: :destroy

  validates :name, :description, :capacity_min, :capacity_max, :duration, :food_menu, presence: true
  validate :at_least_one_address
  validate :at_least_one_service

  private

  def at_least_one_address
    errors.add(:base, "Marque pelo menos uma opção de localização") unless buffet_exclusive_address? || client_specified_address?
  end
  
  def at_least_one_service
    errors.add(:base, "Marque pelo menos uma opção de serviço") unless alcoholic_drinks? || decoration? || parking_service?
  end
end
